CONF_CONTAINER_IP="172.18.0.2"
CONF_HOST_IP="172.18.0.1"
CONF_CONTAINER_NETWORK="shore_net"
CONF_IMAGE_ID="debian:jessie"
CONF_OPEN_BROWSER_ON_START=true
CONF_SERVICES_TO_START=("apache2" "mysql")

CONF_PROJECT_NAME="shore_test"
#CONF_PROJECT_DOMAIN_NAME="shore-test.local"
CONF_PROJECT_HTDOCS="www"
#CONF_PROJECT_INDEX_FILE="index.php"
CONF_PROJECT_CONTAINER_SIDE_PATH="/var/shore"



# Ports mapping list.
# Shore does not require to map ports on Linux because Shore use static IP to 
# allow to gain access to containers. Unfortunately, on Docker for Mac 
# containers, IP addressing is unavailable. 
# @see https://docs.docker.com/docker-for-mac/networking/#/per-container-ip-addressing-is-not-possible
# So on Mac we have to map ports. Uncomment following lines to do so.
#CONF_PROJECT_HTTP_PORT_MAP="80:80"
#CONF_PROJECT_OTHER_PORTS_MAP=("3306:3306")

