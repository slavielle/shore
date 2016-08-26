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

  CONTAINER_PROJECT_DIR_PATH="/home/$PROJECT_NAME"

  # Remap host path to container path
  ORIGIN_CONTAINER_DIR_PATH=${ORIGIN_HOST_DIR_PATH/$HOST_SHARED_DIR_PATH/$CONTAINER_PROJECT_DIR_PATH}
  
  # Loop on script list for the given hook
  while read HOOK_SCRIPT; do

    # Test if $HOOK_SCRIPT is not blank (blank line in the .hook script)
    if [[ "${HOOK_SCRIPT// }" ]]; then

      # Run the hook script and display result
      printf "Triggering hook \"$HOOK_SCRIPT\":\n\n"
      echo "[DEBUG] Using parameters : $ORIGIN_CONTAINER_DIR_PATH $@"
      
      "$(dirname "$0")/../../hooks/scripts/$HOOK_SCRIPT" $ORIGIN_CONTAINER_DIR_PATH $@
      printf "\nHook \"$HOOK_SCRIPT\" triggered\n"
    fi

  done <"$(dirname "$0")/../../hooks/define/on_$HOOK_NAME.hook"
}
