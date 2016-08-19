# dockerhut

## What is it ?
As a web developper developping websites mainly in Drupal, I"m interested in Docker as a web developpement environment (in substitution to VM). 

Dockerhut is an attempt to make an easy to use development environment on top of Docker for people who, like me works on litte or middle size websites development.

Dockerhut is mainly a bunch of bash scripts an a fiew tricks around docker. it use only one container aiming to host runtime environment tools (such as Apache, php, MySQL) and buidling tools (such as gulp, sass, ect) of a project. This way you can easily achive and restore or share your docker image with colleague working on the same projet

## Disclaimer
I'm not a experimented developper on bash script development. My code could certainly be improved. 

So far I tested it on my Ubuntu Xenial Xerus so bare with me if it chashes on other linux systems.

Docker version I used is : Docker version 1.12.0, build 8eab29e. Let's consider it as a minimal version. If you experiencing a problem with higher Docker versions or if it works fine with lower Docker versions please let me know.

and Whatever, feel free to collaborate and pull request me :)

## Requirments

Install docker 1.12.0 or higher (https://get.docker.com/)

## Installing Dockerhut

Create a docker custom network bridge if you hadn't already created one
```
docker network create --subnet=172.18.0.0/16 dockerhut_net
```
dockerhut_net is the name of the network you can change it if you want

Create your project directory

git clone docker hut inside in order to have project/dockerhut.

form your project root execute command
```
dockerhut/install
```
and installation is over

## What we got ?

look into your project directory ...

* The (very basic) Dockerfile will help you to create your project image if you wish

* The container_workspace directory is a directory that will be shared with your container. Its your working directory where your git project will be extracted.

## Preparing or getting a Docker image

build the docker image corresponding to the docker file

On your project directory, execute command : 
```
docker build .
```
dont forget the "."(dot) at the end of the command

You should get finally a ...
```
Successfully built c531b08d1f3e
```
The image ID (c531b08d1f3e) will be different 

## Change settings

project/dockerhut/settings/settings.sh

```
CONTAINER_IP="172.18.0.2"
CONTAINER_NETWORK="dockerhut_net"
IMAGE_ID="c531b08d1f3e"
GIT_URL="https://github.com/slavielle/dockerhut_sample_workspace.git"
```
Set your image ID
Set your Git repository URL

project/dockerhut/settings/shared_settings.sh

```
ROJECT_NAME="dockerhut_test"
PROJECT_HTDOCS="www"
```
Set your project name and your project htdocs

## Initialise your container and get you sources from git

from your project directory execute command

dockerhut/init

## Add your assets

## Copy your database tgz

TO be continued ...








