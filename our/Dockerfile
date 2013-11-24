# VERSION			0.1
# DOCKER VERSION	0.6.6

FROM ubuntu:12.10
MAINTAINER Henrik Vendelbo "hvendelbo@gmail.com"
RUN apt-get -qq update

RUN apt-get install -y language-pack-en
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

RUN apt-get install -y gcc make g++ python-dev python-setuptools supervisor git-core
RUN apt-get install -y openssh-server curl wget libpq5 libpq-dev

RUN easy_install pip
RUN pip install virtualenv
RUN pip install uwsgi
RUN virtualenv --no-site-packages /opt/ve/our
ADD supervisor.conf /etc/supervisor/conf.d/our.conf

# using on production
# ADD .docker/git.sh /opt/git.sh 
# RUN . /opt/git.sh

# our.fluentglobe.com Django based
RUN (mkdir -p /opt/apps)
RUN (cd /opt/apps && git clone https://github.com/fluentglobe/our.git)

ADD settings.py /opt/apps/our/weblate/settings.py
RUN /opt/ve/our/bin/pip install -r /opt/apps/our/requirements.txt
ENTRYPOINT ["/etc/init.d/supervisor","start","&"]

# RUN (cd /opt/apps/our && /opt/ve/our/bin/python manage.py syncdb --noinput)
# RUN (cd /opt/apps/our && /opt/ve/our/bin/python manage.py collectstatic --noinput)

EXPOSE 8000 22
