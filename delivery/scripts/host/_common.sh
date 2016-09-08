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
