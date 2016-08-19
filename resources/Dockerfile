FROM ubuntu:trusty
MAINTAINER Sylvain LAVIELLE <sylvain-lavielle@netelios.fr>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -y install apache2 mysql-server php5 php-pear php5-mysql

RUN a2enmod rewrite

#Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M

