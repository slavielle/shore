function format_output() {

  CODE_IN="\e[49m"
  CODE_OUT="\033[1m\033[0m"

  case "$2" in
    hook)
      CODE_IN="\e[44m"
        ;;

    error)
      CODE_IN="\e[31m"
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
  ORIGIN_CONTAINER_DIR_PATH=${ORIGIN_HOST_DIR_PATH/$HOST_SHARED_DIR_PATH/$CONTAINER_PROJECT_DIR_PATH}
  
  # Loop on script list for the given hook
  while read HOOK_SCRIPT; do

    # Test if $HOOK_SCRIPT is not blank (blank line in the .hook script)
    if [[ "${HOOK_SCRIPT// }" ]]; then

      printf "\n"
      format_output " > HOOK " "hook" " $HOOK_SCRIPT\n\n"

      # Run the hook script and display result
      "$(dirname "$0")/../../hooks/scripts/$HOOK_SCRIPT" $ORIGIN_CONTAINER_DIR_PATH $@

    fi

  done <"$(dirname "$0")/../../hooks/define/on_$HOOK_NAME.hook"
}


