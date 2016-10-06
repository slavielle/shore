# Set you MySQL Root pass here.
CONF_MYSQL_ROOT_PASSWORD="RoOtPas5"

# Set your project database settings here.
# If your got an existing project's sources, you would get these values from 
# the projet settings file (for example get them from the 
# sites/default/settings.php from a regular Drupal project) or redefine them. 
# Anyway following value must match with your project database settings.
# WARRANT:
# Project database user name : Must be no longer than 16 char (16 characters 
# before MySQL 5.7.8 an 32 characters on later versions).
# Project database name must be no longer than 64 characters).
CONF_MYSQL_PROJECT_USER_NAME="shore_test"
CONF_MYSQL_PROJECT_DB_NAME="shore_test"
CONF_MYSQL_PROJECT_USER_PASSWORD="shore_tes7_pa5s"

# Set the path to my.cnf value replacement file here.
CONF_MYSQL_MYCNF_REPLACE_FILE="../settings.mysql_conf.replace"