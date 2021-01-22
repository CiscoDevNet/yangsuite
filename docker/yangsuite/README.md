Copyright 2020 Cisco Systems, Inc

YANG Suite Docker Container
===========================

Instructions on how to install docker-compose client can be found here - https://docs.docker.com/compose/install/.


Creating Container
------------------

docker-compose.yml file contents:

 - A very simple service named "yangsuite"

 - Exposes port 8480 as web interface to YANG Suite

 - Creates a directory named "data" in the folder docker-compose is run from and maps it to /home/docker/data inside container

The "data" directory will contain all settings created while using YANG Suite such as device profiles and YANG repositories
so please make sure it is backed up.  If you need to rebuild the container the settings in the local "data" directory will
be picked up by the new container.

To build and run the container in the foreground, open a terminal, cd to directory containing unzipped files and issue this command:

docker-compose up


One-time Setup
--------------

When the container is built for the first time, you will need to setup a superuser account by running this command:

docker-compose run yangsuite /setuser.sh


Running YANG Suite
------------------

Open a web browser (Microsoft Edge not supported) and go to this URL:

http://localhost:8480

After entering the username setup at install you will be presented with the online help page.  Each page you go to contains
a blue question-mark in the upper right-hand corner.  Clicking on that will bring you to illustrated instructions on how to
use the tool.

Go to https://developer.cisco.com/site/opensource for support and online forums.
