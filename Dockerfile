FROM ubuntu:16.04
MAINTAINER Gyuha Shin <gyuha@gmail.com>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Install packages
ADD provision.sh /provision.sh
ADD start.sh /start.sh

ADD ./nginx-site.conf /etc/nginx/sites-available/default.conf
RUN ln -sf /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default

ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf

RUN chmod +x /*.sh

RUN ./provision.sh

# make wwwroot
RUN mkdir -p /opt && \
mkdir -p /opt/wwwroot

VOLUME ["/opt/wwwroot", "/etc/nginx/ssl"]

EXPOSE 80 443 22
CMD ["/start.sh"]
