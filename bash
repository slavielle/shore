#!/bin/bash

. "$(dirname "$0")/resources/fn.sh"

include_files

docker exec -it $CONTAINER_ID_INITIALIZED /bin/bash
