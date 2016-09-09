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



function run_hook() {

    HOOK_NAME="$1"
    ORIGIN_HOST_DIR_PATH="$2"
    shift 2

    CONTAINER_PROJECT_DIR_PATH="/home/$CONF_PROJECT_NAME"

    # Remap host path to container path
    ORIGIN_CONTAINER_DIR_PATH=${ORIGIN_HOST_DIR_PATH/$RT_HOST_SHARED_DIR_PATH/$CONTAINER_PROJECT_DIR_PATH}

    # Loop on script list for the given hook
    while read HOOK_SCRIPT || [[ -n "$HOOK_SCRIPT" ]]; do
        
        # Trim
        if [[ "$HOOK_SCRIPT" =~ ^[[:space:]]*([^[:space:]].*[^[:space:]])[[:space:]]*$ ]]; then 
            HOOK_SCRIPT=${BASH_REMATCH[1]}
        fi

        # Test if $HOOK_SCRIPT match the regexp
        if [[ $HOOK_SCRIPT =~ ^([0-9a-z_]+)\.([0-9a-z_]*)$ ]]; then
            
            # Run the hook script and display result
            BUNDLE="${BASH_REMATCH[1]}"
            FNC="${BASH_REMATCH[2]}"
            echo ""; format_output " > INVOKE $BUNDLE.$FNC " "hook" "\n\n"
            "$(dirname "$0")/../../bundles/$BUNDLE/hookable_scripts/$FNC" $ORIGIN_CONTAINER_DIR_PATH $@

        elif [[ $HOOK_SCRIPT != \#* ]] && [ ! -z "$HOOK_SCRIPT" ] ; then

            # Catch unmatching values (blank lines and commented lines are ignored)
            echo ""; format_output " > MISMATCH : \"$HOOK_SCRIPT\" " "error" "\n"
        fi

    done <"$(dirname "$0")/../../profiles/$CONF_PROFILE/on_$HOOK_NAME.hook"
}


