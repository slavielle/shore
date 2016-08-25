# shore

## What is it ?

### A web development environment for little or middle sized projects
As a web developper developping websites in Drupal and Symfony, I"m interested in Docker as a local web developpement environment (in substitution to VM). 

Shore is an attempt to make an easy to use web development environment on top of Docker for people who, like me work as a developper on litte or middle sized websites.

Shore is mainly a bunch of bash scripts and a fiew tricks around Docker. It use basically only one container aiming to host runtime environment tools (such as Apache, php, MySQL) and buidling tools (such as gulp, sass, drush, etc) for a project. This way you can easily achive and restore or share your docker image with colleagues working on the same projet, not botherint too much about docker's convolutions.

### My final Goals
  - For a developper : install shore and learn how to use it at a user level in 30 min tops (as a user ... if you have to design the projet it might take a little longer :) )
  - Reinstall an existing project from scratch and be ready to crack on with in 10 min tops
  - No more tools versions or compatibility problem : runtime and building tools in the container make your life easier 

## Disclaimer
* I'm not a experimented developper on bash script development. My code could certainly be improved. 

* So far I tested it on my Ubuntu Xenial Xerus so bare with me if it chashes on other linux systems.

* Docker version I used is : Docker version 1.12.0, build 8eab29e. Let's consider it as a minimal version. If you experiencing a problem with higher Docker versions or if it works fine with lower Docker versions please let me know.

and Whatever, feel free to collaborate and pull request me :)

## Requirments
* Linux system (I didn't test it using boot2Docker on Mac OSX plathform to check if shore host scripts could run. On Windows, you could run it using a VM with Ubuntu or Debian installed even if it's a poor solution), 
* Docker 1.12.0 or higher installed (https://get.docker.com/)

## Installing Shore

Create a docker custom network bridge if you hadn't already created one
```
docker network create --subnet=172.18.0.0/16 shore_net
```
shore_net is the name of the network you can change it if you want

get shore from git and put the shore directory into /usr/lib

Create a symlink in /usr/bin
```
cd /usr/bin
sudo ln -s ../lib/shore/shore doh
```
On my computer, the command to run shore is the short for shore ... "doh". No my name isn't Ommer but yes i like donuts :)

You can now run the command "doh" everywhere
```
$ doh 
shore: no command provided
```
# Use it for a projet

Go into your projet directory. It's must be your git root containing your website's runtime and build scripts and assets. in your project root you must have a directory (genrally called www or htdocs containing a directory exposed to your web server)

form your projet directory execute command : 

```
$ doh install
shore installed
Please edit files in .shore/settings to set setting values
```

Now, look into your project directory using a ls -a command : Among your project's files and directories you have now a .shore directory ... you might want to add it to your .gitignore file and it's a good moment to ;)  

## Yes and what now.

Now comes the tricky part ... we need a docker image to run our project container. Making a docker image for our project will not be discussed here. let's get a simple one.

## Getting docker image

```
docker pull netelios/shore_starter
```
This image is a really simple image based on a debian jessie + Apache, PHP, MySQL

## Change settings

[project root]/.shore/settings/host_settings.sh

```
CONTAINER_IP="172.18.0.2"
CONTAINER_NETWORK="shore_net"
IMAGE_ID="c531b08d1f3e"
```
Set your image ID
Set your Git repository URL

[project root]/.shore/settings/container_settings.sh

```
ROJECT_NAME="shore_test"
PROJECT_HTDOCS="www"
```
Set your project name and your project htdocs

[to be continued]




