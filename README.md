# Shore

## What is it ?

### A runtime environment for web development builds on top of Docker

As a web developer developing websites using, among others, Drupal and Symfony, I’m interested in Docker as a local runtime environment for projects I'm working on. I previously worked with VM, but found it slow and kind of weighing. Hence, I was looking for something having similar advantages but lightweight and powerful.

Docker is a wonderful tool, not that hard to work with and fulfilling completely my former wishes even if it was not really designed for the purpose I wanted to use it. But to be honest, the way I use it, Docker is not really convenient to use daily : You have to fiddle with Docker and/or containerization stuff to find out solutions … that is a tricky part I don’t want to bother with any more.

Shore is an attempt to make an easy to use web development environment on top of Docker for people who like me, work as a developer on little or middle sized website projects based on existing CMS or Frameworks. It is mainly a bunch of bash scripts (host side and container side) and a few tricks around Docker I made to make my developer life easier. It uses basically only one container aiming to run ...

  - Runtime tools (such as Apache, PHP, MySQL, etc.) 
  -	Building tools (such as Gulp, Sass, Drush, etc.) 

... for a project.

This way you can easily archive and restore or share your Docker image with colleagues working on the same project, not bothering too much about Docker’s convolutions.

### My goals are
* For a project contributing developer: 
  - To be able to install shore and learn how to use it at a user level in 10 min tops.
  - To be able to reinstall an existing project from scratch and be ready to crack on with, in 10 min tops.
  - No more runtime or build tools versions or compatibility problem: runtime and building tools in the container make your life easier because every developer works with exactly the same environment.

* For a lead developer: 
  - To be able to setup development environment using a build-in profiles and bundles quickly and effectively.

## Systems (Host and container)
* As Host: 
  - Ubuntu Xenial Xerus. 
  - MacOS : I'm currently updating host scripts for MacOS and Docker for Mac (see [macos_compatibility branch](https://github.com/slavielle/shore/tree/macos_compatibility)) and testing it on MacOS 10.12.2 (Sierra). Shore would have some limitation on MacOS due to [Docker for mac own network limitations](https://docs.docker.com/docker-for-mac/networking/#/known-limitations-use-cases-and-workarounds) but it would shortly work on MacOS Yosemite 10.10.3 and later.
* As Containers: Debian Jessie 

## Requirements
* One of the tested host systems, 
* Docker 1.12.0 or higher installed (https://get.docker.com/)

## Disclaimer
* I'm not an experimented developer on bash script development. My code could certainly be improved. 
* So far I tested it on a very few bunch of systems (as host and container) so; bear with me if some glitches pop up on untested systems.
* Docker version I used is: Docker version 1.12.0, build 8eab29e. Let's consider it as a minimal version: If you experiencing a problem with higher Docker versions or if it works fine with lower Docker versions please let me know.
* Whatsoever, you’re very welcome collaborate the project by forking and send pull-requests, reporting issues, test Shore on other host systems such as MacOS pre Yosemite 10.10.3, Windows, and untested linux disttributions.

## Installing Shore on your computer

### Execute the following command ###
```
curl -s https://gist.githubusercontent.com/slavielle/8b1d358539d7519a33074c17ca0d6e11/raw/c3f9515c4381a9083ba3b7cbb076db9fe2ed942d/install | sudo bash
```
Remote installation script is stored [here](https://gist.github.com/slavielle/8b1d358539d7519a33074c17ca0d6e11) as a github gist. 

install script checking : 
* sha256 checksum : 5b79aeaa9f0ccab829c8fdbd29f59d5a80984a34155d3981be8b605278912a5a 
* md5 checksum : bae65ed6672a53a3472a1a7e5ef60c73

### Create a Docker custom network bridge ###
```
$ docker network create --subnet=172.18.0.0/16 shore_net
```
"shore_net" is the default name I used in the shore's settings file. You can change it if you want.

## Use it for a project

### Step 1 : Install it in a project

Go into your project directory. It's must be your git root containing your website's runtime and build scripts and assets. In your project root you must have a directory (generally called "www" or "htdocs" or "public_html" containing a directory exposed to your web server).

Form your projet directory execute command : 

```
$ shore install
```

Now, look into your project directory using a `ls -a` command : Among your project's files and directories you have now a .shore directory. I advise you to commit this ".shore" directory into your project's git repository (see why in wiki/FAQ). 

### Step 2 : Choose your profile

Depending on the type of project you're working on, you can select a suitable profile. By default, the "default" profile is active. Default profile use a very minial set of bundles : apache2, mysql, php5, xdebug. But it's ok for a first go. If you want to change the profile use foloowing command : 
```
shore profile [my_profile]
```
### Step 3 : Change settings

Command `shore install` or `shore profile` give you a list of settings files - depending on what bundle are used by your profile - you have to fiddle with.

Edit them and change parameters to fit your project.

### Step 4 : Init your container
with `shore init`

### Step 5 : Start your container
with `shore start`

### Step 6 : Display your website page
Every of the previous commands give you hints about what to do next, and If all went right, you should be able to access your website through your Shore environment by now ... Possibly with an error, because ... yes your database was created, but is empty.

## Butter on bread

### My database was created ?

Yes, it should be ... and you should be able to check that using the command line `shore mysql-console -d`
then the SQL command `SHOW DATABASES;`

The shore mysql-console opens mysql console and log you in using MySql root user.

### Ok How do I import my database ?

You have a command for that ...

First, copy your database dump file somewhere in your project directory. Personally, I always have a [project directory]/tmp directory where I put temporary needed stuffs (this directory is excluded from git of course). So you can put it your MySql dump file here or whatever you want in your project director but not outside the project directory.

then from your project directory root use following command :

`shore mysql-import ./tmp/my_project_database.sql`

Then refresh your project page in your browser ... that should work.

### Something else ?

For a first go we're almost done ... 

If you want to access your Shore environment (container) using a console, try

`shore bash -b`

if you're done with your shore environment, stop it using :

`shore stop` or `shore stop-all`

Please don't forget to stop your running shore environments before shutting down your computer. there is nothing to do that automatically for the moment and shutting down your computer without stopping your running Shore environments can cause an issue (see issue #1).

Further informations ? go to Wiki pages ... 
