# Docker bridge name.
CONF_CONTAINER_NETWORK="shore_net"

# Container IP in the Docker bridge range.
# Its advised to define a new one for each of your local projets. This way, you
# would be able to run them together.
CONF_CONTAINER_IP="172.18.0.2"

# Host ip in the Docker bridge network.
# Change it carefully.
CONF_HOST_IP="172.18.0.1"

# Docker source image to use.
# Change this is not advised. Change it carefully.
# Mandatory
CONF_IMAGE_ID="debian:jessie"

# If set to true, Shore will attempt to open browser at start.
CONF_OPEN_BROWSER_ON_START=true

# Services to start on the container.
CONF_SERVICES_TO_START=("apache2" "mysql")

# project name. 
# Mandatory.
CONF_PROJECT_NAME="shore_test"

# Define your project local domain name.
# Not mandatory.
# CONF_PROJECT_DOMAIN_NAME="shore-test.local"

# Webserver entry point. 
# Mandatory.
CONF_PROJECT_HTDOCS="www"

# Webserver entry point script.
# Not Mandatory.
#CONF_PROJECT_INDEX_FILE="index.php"

# Change this is not advised. Change it carefully.
# Mandatory.
CONF_PROJECT_CONTAINER_SIDE_PATH="/var/shore"

# Ports mapping list.
# Shore does not require to map ports on Linux because Shore use static IP to 
# allow to gain access to containers. Unfortunately, on Docker for Mac 
# containers, IP addressing is unavailable. 
# @see https://docs.docker.com/docker-for-mac/networking/#/per-container-ip-addressing-is-not-possible
# So on Mac we have to map ports. Uncomment following lines to do so.
#CONF_PROJECT_HTTP_PORT_MAP="80:80"
#CONF_PROJECT_OTHER_PORTS_MAP=("3306:3306")

