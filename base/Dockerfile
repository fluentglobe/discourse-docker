# -*- sh -*-

FROM ubuntu:12.10

# prevent apt from starting nginx right after the installation
RUN	echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d

RUN echo "deb http://nginx.org/packages/ubuntu/ precise nginx" >> /etc/apt/sources.list
RUN echo "deb-src http://nginx.org/packages/ubuntu/ precise nginx" >> /etc/apt/sources.list
RUN apt-get -qy install curl nano wget
RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add -
RUN apt-get update
