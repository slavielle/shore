function include_files(){
    . .shore/settings.sh

    if test "$(ls -A .shore/runtime)"; then
      for F in .shore/runtime/*.sh; do
         . $F
      done
    fi
}
