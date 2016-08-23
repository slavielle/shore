# dockerhut

## What is it ?
As a web developper developping websites mainly in Drupal, I"m interested in Docker as a web developpement environment (in substitution to VM). 

Dockerhut is an attempt to make an easy to use development environment on top of Docker for people who, like me works on litte or middle size websites development.

Dockerhut is mainly a bunch of bash scripts an a fiew tricks around docker. it use only one container aiming to host runtime environment tools (such as Apache, php, MySQL) and buidling tools (such as gulp, sass, ect) of a project. This way you can easily achive and restore or share your docker image with colleague working on the same projet

## Disclaimer
* I'm not a experimented developper on bash script development. My code could certainly be improved. 

* So far I tested it on my Ubuntu Xenial Xerus so bare with me if it chashes on other linux systems.

* Docker version I used is : Docker version 1.12.0, build 8eab29e. Let's consider it as a minimal version. If you experiencing a problem with higher Docker versions or if it works fine with lower Docker versions please let me know.

and Whatever, feel free to collaborate and pull request me :)

## Requirments
* Linux system (I didn't test using boot2Docker on others plathform, let me now if it works well), 
* Docker 1.12.0 or higher installed (https://get.docker.com/)

## Installing Dockerhut

Create a docker custom network bridge if you hadn't already created one
```
docker network create --subnet=172.18.0.0/16 dockerhut_net
```
dockerhut_net is the name of the network you can change it if you want

get dockerhut from git and put the dockerhut directory into /usr/lib

Create a symlink in /usr/bin
```
cd /usr/bin
sudo ln -s ../lib/dockerhut/dockerhut doh
```
On my computer, the command to run dockerhut is the short for dockerhut ... "doh" and yes i like donuts :)

You can now run the command "doh" everywhere
```
$ doh 
dockerhut: no command provided
```
# Use it for a projet

Go into your projet directory. It's must be your git root containing your website's runtime and build scripts and assets. in your project root you must have a directory (genrally called www or htdocs containing a directory exposed to your web server)

form your projet directory execute command : 

```
$ doh install
dockerhut installed
Please edit files in .dockerhut/settings to set setting values
```

Now, look into your project directory using a ls -a command : Among your project's files and directories you have now a .dockerhut directory ... you might want to add it to your .gitignore file and it's a good moment to ;)  

## Yes and what now.

Now comes the tricky part ... we need a docker image to run our project container. Making a docker image for our project will not be discussed here. let's get a simple one.

## Getting docker image

[part still to write]

## Change settings

[project root]/.dockerhut/settings/host_settings.sh

```
CONTAINER_IP="172.18.0.2"
CONTAINER_NETWORK="dockerhut_net"
IMAGE_ID="c531b08d1f3e"
```
Set your image ID
Set your Git repository URL

[project root]/.dockerhut/settings/container_settings.sh

```
ROJECT_NAME="dockerhut_test"
PROJECT_HTDOCS="www"
```
Set your project name and your project htdocs

[to be continued]




