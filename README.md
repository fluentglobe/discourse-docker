<!-- -*- mode: Markdown; -*- -->

discourse-docker
================

[Discourse](http://discourse.org/) is a re-imagined online forum
software. Installing Discourse can be quite an involved process. We
use [Docker](http://www.docker.io/), an exciting new container
management tool, to greatly ease its install process.

Usage
-----

Get yourself a Ubuntu 13.04 VM (I recommend
[DigitalOcean](https://www.digitalocean.com/?refcode=efb0b61918fa)),
and start getting Discourse up and running in a few minutes:

```bash
# Install docker
open http://docs.docker.io/en/latest/installation/ubuntulinux/#ubuntu-raring

# Install postgresql-client for management-tasks
apt-get install postgresql-client

# Install supervisor, the process manager
sudo apt-get install python-pip
sudo pip install supervisor

git clone git@github.com:fluentglobe/fluentglobe-docker.git

git clone https://github.com/fluentglobe/fluentglobe-docker.git
cd discourse-docker

# Pull the docker images (expect this to download a few megabytes)
make pull  # or `make build` if you want to locally build them

# Configure your discourse site domain (DISCOURSE_HOST)
more etc/env
echo 'export DISCOURSE_HOST=mysite.com:5000' > .env
# OPTIONAL: email support via postmarkapp.com.
# later, add the 'From' address to Discourse admin settings.
echo 'export POSTMARK_API_KEY=<apikey>' >> .env
```

Start supervisor on a separate terminal window. This will
automatically start the redis and postgresql containers.

    make supervisor &

This will kill the dockers if you press Ctrl-C

```
# Verify that redis-server and postgres are running.
# Note: bin/sup is alias to `sudo supervisorctl`.
bin/sup status

# Setup the discourse database and compile static assets.
# Note: postgres data is at data/postgres; discourse public/
# (containing uploaded files) directory is mounted from
# data/discourse-public.
bin/discourse-start setup

# Finally, start discourse, django, sidekiq and nginx
bin/sup start discourse sidekiq nginx

# Discourse is now running; launch the discourse site URL.
make info

# After signing up for an account, make yourself an admin:
bin/make-admin myusername
```

Where's the Stuff
-----------------

In `data` you find the data for the running dockers

In `tmp` you find the logs

Migration
---------

To migrate from an existing Discourse forum:

0. Start only postgresql,redis

1. Take a snapshot of the database and import it right after starting
   the postgresql container.
   
2. Run `bin/discourse-start setup`. If the assets creation step fails,
   try re-running it using `bin/discourse-start "bundle exec rake
   assets:precompile"`.
   
3. Import public/uploads directory into data/discourse-public/uploads

4. Start everything: bin/sup start all


Issues
------

If you see the following run `supervisord`

root@a:~/fluentglobe-docker# bin/sup start nginx
unix:///tmp/supervisord-docker.sock no such file

