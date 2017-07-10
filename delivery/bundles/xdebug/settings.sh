CONF_XDEBUG_INSTALL_LIST=()

# Activates(uncomment) or add xdebug configuration options.
CONF_XDEBUG_INSTALL_LIST+=('xdebug.remote_enable=1')
CONF_XDEBUG_INSTALL_LIST+=('xdebug.remote_handler=dbgp')
CONF_XDEBUG_INSTALL_LIST+=('xdebug.remote_mode=req')
CONF_XDEBUG_INSTALL_LIST+=('xdebug.remote_host=$CONF_HOST_IP')
CONF_XDEBUG_INSTALL_LIST+=('xdebug.remote_port=9000')

# Following line can be requiered for Durpal 8 or Symfony.
# CONF_XDEBUG_INSTALL_LIST+=('xdebug.max_nesting_level=256')