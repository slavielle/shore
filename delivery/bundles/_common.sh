
# This script is a part of Shore
# MIT License
# Copyright (c) 2016 Sylvain LAVIELLE


function include_files(){

    # Include global settings
    . "$(dirname "$0")/../../../settings.sh"

    # Include bundle settings
    if [ -f "$(dirname "$0")/../settings.sh" ]; then
        . "$(dirname "$0")/../settings.sh"
    fi

    # Include Runtime variables
    if test "$(ls -A "$(dirname "$0")/../../../runtime")"; then
        for F in "$(dirname "$0")/../../../runtime/*.sh"; do
            . $F
        done
    fi
}
