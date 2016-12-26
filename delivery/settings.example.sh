CONF_CONTAINER_IP="172.18.0.2"
CONF_HOST_IP="172.18.0.1"
CONF_CONTAINER_NETWORK="shore_net"
CONF_IMAGE_ID="debian:jessie"
CONF_OPEN_BROWSER_ON_START=true
CONF_SERVICES_TO_START=("apache2" "mysql")

#CONF_PROJECT_NAME="shore_test"
#CONF_PROJECT_DOMAIN_NAME="shore-test.local"
#CONF_PROJECT_HTDOCS="www"
#CONF_PROJECT_INDEX_FILE="index.php"


# Ports mapping list.
# Shore does not need to map ports on linux because Shore gain access to 
# container using static IP. Unfortunately, on Docker for Mac container IP 
# addressing is unavailable. 
# @see https://docs.docker.com/docker-for-mac/networking/#/per-container-ip-addressing-is-not-possible
# So on Mac we have to map ports. Uncomment following line to do so.
#CONF_PROJECT_PORTS_MAP=("80:80")

