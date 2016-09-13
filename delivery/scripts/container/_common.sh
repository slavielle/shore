
# This script is a part of Shore
# MIT License
# Copyright (c) 2016 Sylvain LAVIELLE


function format_output() {

  CODE_IN="\e[49m"
  CODE_OUT="\033[1m\033[0m"

  case "$2" in
    hook)
      CODE_IN="\e[44m"
        ;;

    error)
      CODE_IN="\e[41m"
        ;;

    warning)
      CODE_IN="\e[93m"
        ;;

    success)
      CODE_IN="\e[92m"
        ;;
  esac

  printf "\033[1m${CODE_IN}$1${CODE_OUT}$3"

}



function include_files(){

    . "$(dirname "$0")/../../settings.sh"

    for F in "$(dirname "$0")"/../../runtime/*.sh; do
       . $F
    done
}


array_contains () { 
    local ARRAY="$1[@]"
    local SEEKING=$2
    local IN=1
    for ELEMENT in "${!ARRAY}"; do
        if [[ $ELEMENT == $SEEKING ]]; then
            IN=0
            break
        fi
    done
    return $IN
}


function run_hook() {

    HOOK_NAME="$1"
    ORIGIN_HOST_DIR_PATH="$2"
    shift 2

    CONTAINER_PROJECT_DIR_PATH="/home/$CONF_PROJECT_NAME"

    # Remap host path to container path
    ORIGIN_CONTAINER_DIR_PATH=${ORIGIN_HOST_DIR_PATH/$RT_HOST_SHARED_DIR_PATH/$CONTAINER_PROJECT_DIR_PATH}

    # List enabled bundles
    ENABLED_BUNDLES=()
    ENABLED_BUNDLES_LIST_FILE=$(readlink -f "$(dirname "$0")/../../profiles/$CONF_PROFILE/bundles")
    while read BUNDLE || [[ -n "$BUNDLE" ]]; do

        # Trim
        if [[ "$BUNDLE" =~ ^[[:space:]]*([^[:space:]].*[^[:space:]])[[:space:]]*$ ]]; then 
            BUNDLE=${BASH_REMATCH[1]}
        fi

        # Add bundle to ENABLED_BUNDLES array if bundle name match
        if [[ $BUNDLE =~ ^([0-9a-z_]+)$ ]]; then
            ENABLED_BUNDLES+=("$BUNDLE")
        elif [[ $BUNDLE != \#* ]] && [ ! -z "$BUNDLE" ] ; then
            echo ""; format_output " > MISMATCH : \"$BUNDLE\" in \"$ENABLED_BUNDLES_LIST_FILE\" " "error" "\n"
        fi
    done <"$ENABLED_BUNDLES_LIST_FILE"


    # Loop on script list for the given hook
    HOOK_SCRIPT_LIST_FILE=$(readlink -f "$(dirname "$0")/../../profiles/$CONF_PROFILE/on_$HOOK_NAME.hook")
    while read HOOK_SCRIPT || [[ -n "$HOOK_SCRIPT" ]]; do
        
        # Trim
        if [[ "$HOOK_SCRIPT" =~ ^[[:space:]]*([^[:space:]].*[^[:space:]])[[:space:]]*$ ]]; then 
            HOOK_SCRIPT=${BASH_REMATCH[1]}
        fi

        # Test if $HOOK_SCRIPT match the regexp
        if [[ $HOOK_SCRIPT =~ ^([0-9a-z_]+)\.([0-9a-z_]*)$ ]]; then
            HOOK_BUNDLE=${BASH_REMATCH[1]}
            if array_contains ENABLED_BUNDLES $HOOK_BUNDLE; then
                # Run the hook script and display result
                BUNDLE="${BASH_REMATCH[1]}"
                FNC="${BASH_REMATCH[2]}"
                echo ""; format_output " > INVOKE $BUNDLE.$FNC " "hook" "\n\n"
                "$(dirname "$0")/../../bundles/$BUNDLE/hookable_scripts/$FNC" $ORIGIN_CONTAINER_DIR_PATH $@
            else
                echo ""; format_output " > BUNDLE DISABLED FOR: \"$HOOK_SCRIPT\" " "error" "\n"
            fi
        elif [[ $HOOK_SCRIPT != \#* ]] && [ ! -z "$HOOK_SCRIPT" ] ; then

            # Catch unmatching values (blank lines and commented lines are ignored)
            echo ""; format_output " > MISMATCH : \"$HOOK_SCRIPT\" in \"$HOOK_SCRIPT_LIST_FILE\" " "error" "\n"
        fi

    done <"$HOOK_SCRIPT_LIST_FILE"
}


