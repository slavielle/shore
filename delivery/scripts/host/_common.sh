
# This script is a part of Shore
# MIT License
# Copyright (c) 2016 Sylvain LAVIELLE


function include_files(){

    BUNDLE_NAME="$1"

    # Include core settings
    . .shore/settings.sh

    # Include bundle settings
    if [ "$BUNDLE_NAME" ] && [ -f ".shore/bundles/$BUNDLE_NAME/settings.sh" ]; then
        #echo "import .shore/bundles/$BUNDLE_NAME/settings.sh"
        . ".shore/bundles/$BUNDLE_NAME/settings.sh"
    fi

    # Include runtime var
    if test "$(ls -A .shore/runtime)"; then
        for F in .shore/runtime/*.sh; do
           . $F
        done
    fi
}


function format_output() {

  CODE_IN="\e[49m"
  CODE_OUT="\033[1m\033[0m"

  case "$2" in
    step)
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
