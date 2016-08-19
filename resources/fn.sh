function include_files(){
    . "$(dirname "$0")/settings/settings.sh"
    . "$(dirname "$0")/settings/shared_settings.sh"

    if test "$(ls -A "$(dirname "$0")/runtime")"; then
      for F in "$(dirname "$0")"/runtime/*.sh; do
         . $F
      done
    fi
}
