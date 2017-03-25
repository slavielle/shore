
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
        RUNTIME_PATH=$(realpath "$(dirname "$0")/../../../runtime")
        for F in "$RUNTIME_PATH"/*; do
            . $F
        done
    fi
}

function replace(){
    SOURCE_FILE=$1
    RULES_FILE=$2

    SOURCE_DATA=$(cat "$SOURCE_FILE")
    RULES_DATA=$(cat "$RULES_FILE")
    OUTPUT_DATA=""

    while read -r SOURCE_LINE; do
        unset RULE_IN
        unset RULE_OUT
        while read -r RULES_LINE; do	
            if [[ $RULES_LINE == "i:"* ]]; then
                RULE_IN=${RULES_LINE#"i:"}
            elif [[ $RULES_LINE == "o:"* ]]; then
                RULE_OUT=${RULES_LINE#"o:"}
                if ( [[ $RULE_IN ]]); then
                    if [[ $SOURCE_LINE =~ $RULE_IN ]]; then
                        LINE_OUTPUT=""
                        while [[ $RULE_OUT =~ (.?)(##\[[A-Z_]+\]##)*(.*) ]]; do
			    [[ ! ${BASH_REMATCH[1]} ]] && break
			    LINE_OUTPUT=$LINE_OUTPUT${BASH_REMATCH[1]}
                            if [[ ${BASH_REMATCH[2]} ]]; then
                                VAR_NAME=${BASH_REMATCH[2]} 
                                VAR_NAME=${VAR_NAME#"##["}
                                VAR_NAME=${VAR_NAME%"]##"}
                                VAR_VAL=${!VAR_NAME}
                                LINE_OUTPUT=$LINE_OUTPUT$VAR_VAL
                            fi
			    RULE_OUT=${BASH_REMATCH[3]}
                        done		
			break
                    else 
                        LINE_OUTPUT=$SOURCE_LINE 
		    fi		    
                else
		    echo "replace input missing"
                    exit
                fi
	    else
	        echo "replace format error on: $RULES_LINE "
                exit
	    fi

        done <<< "$RULES_DATA"
        OUTPUT_DATA="$OUTPUT_DATA$LINE_OUTPUT"$'\n'  
    done <<< "$SOURCE_DATA"

    SOURCE_DATA="$OUTPUT_DATA"
    rm $SOURCE_FILE
    echo "$SOURCE_DATA" > $SOURCE_FILE
}

function get_log_file_path(){
    RET="/dev/null"
    if [ ! -z "$RT_LOG_FILES_NAME_PART_1" ] && [ ! -z "$RT_LOG_FILES_NAME_PART_2" ]; then
        mkdir -p "$CONF_PROJECT_CONTAINER_SIDE_PATH/.shore/logs"
        RET="$CONF_PROJECT_CONTAINER_SIDE_PATH/.shore/logs/$RT_LOG_FILES_NAME_PART_1$RT_LOG_FILES_NAME_PART_2.log"
    fi
    echo $RET
}

function write_log_start_section(){
    if [ ! -z "$1" ]; then
        echo ""
        echo ""
        echo "#>>>>>>>>>> START-SECTION : $1"
        echo ""
        echo ""
    fi
}

function write_log_end_section(){
    if [ ! -z "$1" ]; then
        echo ""
        echo ""
        echo "#<<<<<<<<<< END-SECTION : $1"
    fi
}
