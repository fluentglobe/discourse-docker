# -*- sh -*-

FROM ubuntu:12.10

# prevent apt from starting nginx right after the installation
RUN	echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d

RUN echo "deb http://nginx.org/packages/ubuntu/ precise nginx" >> /etc/apt/sources.list
RUN echo "deb-src http://nginx.org/packages/ubuntu/ precise nginx" >> /etc/apt/sources.list
RUN apt-get -qy install curl nano wget
RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add -
RUN apt-get update
RUN apt-get -qy install nginx-extras

# RUN echo "daemon off;" >> /etc/nginx/nginx.conf

ADD start /
RUN chmod +x /start

VOLUME ["/var/log/nginx/"]

ADD nginx.conf /etc/nginx/
ADD default.conf /etc/nginx/sites-enabled/
ADD discourse.conf /etc/nginx/sites-enabled/
ADD our.conf /etc/nginx/sites-enabled/

#TODO HOSTIP = $HOSTIP

ENV OUR_HOST our.fluentglobe.com
ENV DISCOURSE_HOST hello.fluentglobe.com
ENV OUR_PORT 8000
ENV DISCOURSE_PORT 3000

ADD set-env /usr/local/bin/
RUN chmod +x /usr/local/bin/set-env
RUN set-env

EXPOSE 80
#CMD /start
CMD nginx

