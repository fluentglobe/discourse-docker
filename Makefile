all:
	echo

build:
	sudo docker build -t fluentglobe/discourse discourse
	sudo docker build -rm -t "fluentglobe/postgresql:9.1" postgresql
	sudo docker build -rm -t "fluentglobe/redis:2.6" redis
	sudo docker build -rm -t "fluentglobe/nginx" nginx
	sudo docker build -t "fluentglobe/our" our
	sudo docker images | grep fluentglobe

run-nginx:
	docker run -i \
		-e DISCOURSE_PORT=3000 -e HOSTIP=146.185.169.23 -e DISCOURSE_HOST=hello.fluentglobe.com \
		-e OUR_PORT=8000 -e OUR_HOST=our.fluentglobe.com \
		-p 80:80 -v /root/fluentglobe-docker/data/discourse-public:/discourse-public \
		-v /root/fluentglobe-docker/data/our-public:/our-public \
		-v /var/log/nginx:/var/log/nginx \
		-t fluentglobe/nginx /bin/bash

nginx-image:
	sudo docker build -t fluentglobe/nginx nginx
	sudo docker images | grep fluentglobe/nginx

build-discourse-only:
	sudo docker build -t fluentglobe/discourse discourse
	sudo docker images | grep fluentglobe/discourse

pull:
	sudo docker pull fluentglobe/nginx
	sudo docker pull fluentglobe/redis
	sudo docker pull fluentglobe/postgresql
	sudo docker pull fluentglobe/discourse
	sudo docker pull fluentglobe/our

push:
	sudo docker push fluentglobe/discourse-nginx
	sudo docker push fluentglobe/redis
	sudo docker push fluentglobe/postgresql
	sudo docker push fluentglobe/discourse
	sudo docker push fluentglobe/our

ps:
	sudo docker ps 

supervisor:
	sudo `which supervisord` -n -c etc/supervisord.conf

info:
	bin/nginx-info
