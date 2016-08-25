function include_files(){
    . .shore/settings/host_settings.sh
    . .shore/settings/container_settings.sh

    if test "$(ls -A .shore/runtime)"; then
      for F in .shore/runtime/*.sh; do
         . $F
      done
    fi
}
