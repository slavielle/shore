
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

    error_item)
      CODE_IN="\e[91m"
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

    CONTAINER_PROJECT_DIR_PATH="$CONF_PROJECT_CONTAINER_SIDE_PATH"

    # Remap host path to container path
    ORIGIN_CONTAINER_DIR_PATH=${ORIGIN_HOST_DIR_PATH/$RT_HOST_SHARED_DIR_PATH/$CONTAINER_PROJECT_DIR_PATH}

    # List enabled bundles
    ENABLED_BUNDLES=("system") #system enabled by default
    ENABLED_BUNDLES_LIST_FILE=$(realpath "$(dirname "$0")/../../profiles/$RT_PROFILE/bundles")

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


    # Locate the hook.
    HOOK_SCRIPT_LIST_FILE=$(realpath "$(dirname "$0")/../../profiles/$RT_PROFILE/on_$HOOK_NAME.hook")
    if [ ! -f "$HOOK_SCRIPT_LIST_FILE" ]; then
        HOOK_SCRIPT_LIST_FILE=$(realpath "$(dirname "$0")/../../hooks/on_$HOOK_NAME.hook")
    fi

    # Loop on script list for the given hook
    MODE_LIST=("check" "run")
    ERRORS=0
    for MODE in ${MODE_LIST[@]}; do
        if (( $ERRORS == 0 )) ; then
            LINE_COUNT=0
            while read HOOK_SCRIPT || [[ -n "$HOOK_SCRIPT" ]]; do
                LINE_COUNT=$((LINE_COUNT + 1))
                # Trim
                if [[ "$HOOK_SCRIPT" =~ ^[[:space:]]*([^[:space:]].*[^[:space:]])[[:space:]]*$ ]]; then 
                    HOOK_SCRIPT=${BASH_REMATCH[1]}
                fi

                # Test if $HOOK_SCRIPT match the regexp
                if [[ $HOOK_SCRIPT =~ ^([0-9a-z_]+)\.([0-9a-z_]*)$ ]]; then

                    HOOK_BUNDLE=${BASH_REMATCH[1]}

                    if array_contains ENABLED_BUNDLES $HOOK_BUNDLE; then

                        if [ "$MODE" == "run" ]; then

                            # Get the name of the bundle and action to run
                            BUNDLE="${BASH_REMATCH[1]}"
                            FNC="${BASH_REMATCH[2]}"

                            # Define the log file part 2 name
                            echo "RT_LOG_FILES_NAME_PART_2=\"-$BUNDLE-$FNC\"" > "$CONTAINER_PROJECT_DIR_PATH/.shore/runtime/RT_LOG_FILES_NAME_PART_2.var.sh"

                            # Run the hook script and display result
                            echo ""; format_output " > INVOKE $BUNDLE.$FNC " "hook" "\n\n"
                            "$(dirname "$0")/../../bundles/$BUNDLE/hookable_scripts/$FNC" $ORIGIN_CONTAINER_DIR_PATH $@
                        fi

                    else

                        if [ "$MODE" == "check" ]; then
                            ERRORS=$((ERRORS + 1))
                            echo ""; format_output " > Error(L$LINE_COUNT): \"$HOOK_BUNDLE\" bundle disabled on \"$HOOK_SCRIPT\" " "error_item"
                        fi
                    fi

                elif [[ $HOOK_SCRIPT != \#* ]] && [ ! -z "$HOOK_SCRIPT" ] ; then

                    if [ "$MODE" == "check" ]; then
                        # Catch unmatching values (blank lines and commented lines are ignored)
                        ERRORS=$((ERRORS + 1))
                        echo ""; format_output " > Error(L$LINE_COUNT): Line mismatch on \"$HOOK_SCRIPT\"" "error_item"
                    fi
                fi

            done <"$HOOK_SCRIPT_LIST_FILE"
        fi
    done

    if (( $ERRORS > 0 )) ; then
        echo "";echo ""; format_output " > ABORT : Errors detected on hook \"$HOOK_NAME\" in \"$HOOK_SCRIPT_LIST_FILE\"" "error" "\n";echo ""
    fi
}


