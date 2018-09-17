# Node version to provide to the n command. See https://github.com/tj/n .
CONF_NODE_VERSION="lts"
CONF_NODE_NODE_REPO_URL="https://deb.nodesource.com/setup_8.x"

# Activates(uncomment) or add node modules to install globally for your project.
CONF_NODE_INSTALL_GLOBAL=()
CONF_NODE_INSTALL_GLOBAL+=("gulp-cli")
CONF_NODE_INSTALL_GLOBAL+=("bower")

# Path to where the package.json is located. This path is a relative path from  
# your project directory.
#CONF_NODE_PACKAGE_JSON_DIR="path/to/your/dir/containing/node/package/file"

