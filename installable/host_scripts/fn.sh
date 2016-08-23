function include_files(){
    . .dockerhut/settings/host_settings.sh
    . .dockerhut/settings/container_settings.sh

    if test "$(ls -A .dockerhut/runtime)"; then
      for F in .dockerhut/runtime/*.sh; do
         . $F
      done
    fi
}
