# Shore

## What is it ?

### A runtime environment for web development builds on top of Docker

As a web developer developing websites using, among others, Drupal and Symfony, I’m interested in Docker as a local runtime environment for projects I'm working on. I previously worked with VM, but found it slow and kind of weighing. Hence, I was looking for something having similar advantages but lightweight and powerful.

Docker is a wonderful tool, not that hard to work with and fulfilling completely my former wishes even if it was not really designed for the purpose I wanted to use it. But to be honest, the way I use it, Docker is not really convenient to use daily : You have to fiddle with Docker and/or containerization stuff to find out solutions … that is a tricky part I don’t want to bother with again.

Shore is an attempt to make an easy to use web development environment on top of Docker for people who like me, work as a developer on little or middle sized website projects based on existing CMS or Frameworks. It is mainly a bunch of bash scripts (host side and container side) and a few tricks around Docker I made to make my developer life easier. It uses basically only one container aiming to run ...

  - Runtime tools (such as Apache, PHP, MySQL, etc.) 
  -	Building tools (such as Gulp, Sass, Drush, etc.) 

... for a project.

This way you can easily archive and restore or share your Docker image with colleagues working on the same project, not bothering too much about Docker’s convolutions.

Shore is structured in bundles that you can use from profiles.
 - Bundle neans a bundle of scripts for one given tool or language : Here's a few bundles you can use in shore : mysql, apache2, php5, composer, drush, node, ruby, etc ...
 - Profiles gather some bundles and can invoque them through shore commands. To illustrate why profiles are usefull, lets imagine 2 of them such as a drupal 7 one and a symfony 2 one. Both of them may use apache2, mysql, and php5 bundles but when the drupal one would use the drush bundle, the symfony one should use the composer one.

### My goals are
* For a project contributing developer: 
  - To be able to install shore and learn how to use it at a user level in 10 min tops.
  - To be able to reinstall an existing project from scratch and be ready to crack on with, in 10 min tops.
  - No more runtime or build tools versions or compatibility problem: runtime and building tools in the container make your life easier because every developer works with exactly the same environment.

* For a lead developper : 
  - To be able to setup devemopment environment using a build-in profiles and bundles as quickly as effectively.

## Disclaimer
* I'm not an experimented developer on bash scriptintg development. My code could certainly be improved. 
* So far I tested it on a very few bunch of systems (as host and container) so; bear with me if some glitches pop up on those untested systems. See "tested systems" section.
* Docker version I used is: Docker version 1.12.0, build 8eab29e. Let's consider it as a minimal version: If you experiencing a problem with higher Docker versions or if it works fine with lower Docker versions please let me know.
Anyway, you’re very welcome collaborate the project by forking and send pull request, reporting issues, etc.

## Tested systems
### as Hosts:
* Ubuntu Xenial Xerus

### as Containers:
* Debian Jessie 

## Requirements
* One to the tested host Linux systems. (I didn't test it using boot2Docker on Mac OSX platform to check if shore host scripts could run on it. On Windows, you should run it using a VM with one to the tested host Linux systems installed even if it's a poor solution), 
* Docker 1.12.0 or higher installed (https://get.docker.com/)

## Installing Shore on your computer

Create a Docker custom network bridge if you hadn't already created one
```
$ docker network create --subnet=172.18.0.0/16 shore_net
```
"shore_net" is the default name I use in shore's settings file. You can change it if you want.

Get Shore from git and put the shore directory into your /usr/lib directory.

```
$ cd /usr/lib
$ git clone git@github.com:slavielle/shore.git
```

Create a symlink in /usr/bin
```
$ cd /usr/bin
$ sudo ln -s ../lib/shore/shore shore
```

## Use it for a project

### Step 1 : Install it in a project

Go into your project directory. It's must be your git root containing your website's runtime and build scripts and assets. In your project root you must have a directory (generally called "www" or "htdocs" containing a directory exposed to your web server).

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

If you wand to access your Shore environment (container) using a console, try

`shore bash -b`

if you're done with your shore environment, stop it using :

`shore stop` or `shore stop-all`

Please don't forget to stop your running shore environments before shutting down your computer. there is nothing to do that automatically for the moment and shutting down your computer withour stopping your running shore environments can cause problem (see issue #1).

Further informations ? go to Wiki pages ...



