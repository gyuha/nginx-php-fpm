FROM ubuntu:16.04
MAINTAINER Gyuha Shin <gyuha@gmail.com>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Install packages
ADD provision.sh /provision.sh
ADD start.sh /start.sh

ADD ./conf/nginx-site.conf /tmp/nginx-site.conf
ADD ./conf/supervisor.conf /tmp/supervisor.conf

RUN chmod +x /*.sh

RUN ./provision.sh

# make wwwroot
RUN mkdir -p /opt && \
mkdir -p /opt/wwwroot

VOLUME ["/opt/wwwroot", "/etc/nginx/ssl"]

EXPOSE 80 443 22
CMD ["/start.sh"]
