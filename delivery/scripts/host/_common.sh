
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

function define_network_settings() {

    local INPUT_CONTAINER_NETWORK

    read -p "Enter Shore bridge network [shore_net]: " INPUT_CONTAINER_NETWORK
    if [ -z "$INPUT_CONTAINER_NETWORK" ]; then
        INPUT_CONTAINER_NETWORK="shore_net"
    fi

    save_runtime_var "RT_CONTAINER_NETWORK" "$INPUT_CONTAINER_NETWORK"
    save_runtime_var "RT_HOST_IP" $(input_ip "Enter host IP [172.18.0.1]" "172.18.0.1")
    save_runtime_var "RT_CONTAINER_IP" $(input_ip "Enter container IP")

}

function save_runtime_var() {
    local VAR_NAME="$1"
    local VAR_VALUE="$2"
    echo "$VAR_NAME=\"$VAR_VALUE\"" > .shore/runtime/$VAR_NAME.var.sh

    eval $VAR_NAME="$VAR_VALUE"
}

function input_ip() {
    local INPUT
    local MESSAGE="$1"
    local DEFAULT_VALUE="$2"

    while :; do
        read -p "$MESSAGE: " INPUT
        if [ -z "$INPUT" ]; then
            INPUT="$DEFAULT_VALUE"
        fi
        if [[ $INPUT =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
            break
        else
            echo "Value does not fit. Please try again" >&2
        fi
    done
    echo "$INPUT"
}
