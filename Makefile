all:
	echo

build:
	sudo docker build -t fluentglobe/discourse discourse
	sudo docker build -t "fluentglobe/postgresql:9.1" postgresql
	sudo docker build -t "fluentglobe/redis:2.6" redis
	sudo docker build -t "fluentglobe/nginx" nginx
	sudo docker images | grep fluentglobe

discourse-image:
	sudo docker build -t fluentglobe/discourse discourse
	sudo docker images | grep fluentglobe/discourse

pull:
	sudo docker pull fluentglobe/nginx
	sudo docker pull fluentglobe/redis
	sudo docker pull fluentglobe/postgresql
	sudo docker pull fluentglobe/discourse
	sudo docker pull fluentglobe/weblate

push:
	sudo docker push fluentglobe/discourse-nginx
	sudo docker push fluentglobe/redis
	sudo docker push fluentglobe/postgresql
	sudo docker push fluentglobe/discourse
	sudo docker push fluentglobe/weblate

ps:
	sudo docker ps 

supervisor:
	sudo `which supervisord` -n -c etc/supervisord.conf

info:
	bin/nginx-info
