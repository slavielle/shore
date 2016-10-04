<?php

// Download composer setup installer. This script had been copied from 
// https://getcomposer.org/download/

copy('https://getcomposer.org/installer', 'composer-setup.php');
if (hash_file('SHA384', 'composer-setup.php') === $argv[1]) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;

