function include_files(){
    . "$(dirname "$0")/../../settings/host_settings.sh"
    . "$(dirname "$0")/../../settings/container_settings.sh"

    if test "$(ls -A "$(dirname "$0")/../../runtime")"; then
      for F in "$(dirname "$0")/../../runtime/*.sh"; do
         . $F
      done
    fi
}
