django on a Ubuntu Docker Instance
=============

Weblate will be deployed on a Ubuntu Docker Instance

URL: our.fluentglobe.com (http://146.185.169.23)



Dockerfile
----------

With a tag for easier reuse

    $ sudo docker build  -t fluentglobe/our github.com/fluentglobe/our

Running the container

    $ sudo docker run -d -p :8000 fluentglobe/our

Now go to `<your ip>:8000` in your browser

Nginx on the host system will proxy requests from port 80 to 8000


More
----

To deploy the following command will be run,

docker build -t fluentglobe/our github.com/fluentglobe/our

on

OS: Ubuntu 13.04.3 x64
Docker: 0.6.6
Deis: Future
Python: 2.7.3
DB: PostgresSQL 9.1.10
pip: 1.3.1
git: 1.8.1.2


This will clone the github repo to /opt/apps/our and run the Dockerfile.
(https://www.docker.io/learn/dockerfile/level1/)

Interactive shell> docker run -i -t fluentglobe/our bash


Docker info found here

https://www.docker.io/gettingstarted/#
(Future: http://deis.io/overview/)

https://www.digitalocean.com/community/articles/how-to-use-the-digitalocean-docker-application



TODO
====

Consider removing installs in the Dockerfile

Make sure the Create VirtualEnv with Django 1.6 & Weblate 1.8 is correct.

Mount outside filesystem so PO file export can be done there
Connect to PSQL outside

https://github.com/srid/discourse-docker


Already run on the box
++++++++++++++++++++++

apt-get install python-pip
apt-get install nginx-naxsi
service nginx start
apt-get install postgresql-9.1 postgresql-client-9.1 postgresql-9.1-postgis
 