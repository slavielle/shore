function run_hook() {
  while read HOOK; do

    # Test if $HOOK is not blank (blank line in the .hook script)
    if [[ "${HOOK// }" ]]; then

      # Run the hook script and display result
      printf "Triggering hook \"$HOOK\":\n\n"
      "$(dirname "$0")/../../hooks/scripts/$HOOK"
      printf "\nHook \"$HOOK\" triggered\n"
    fi

  done <"$(dirname "$0")/../../hooks/define/on_$1.hook"
}
