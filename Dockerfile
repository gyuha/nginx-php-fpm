FROM ubuntu:16.04
MAINTAINER Gyuha Shin <gyuha@gmail.com>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Update Package List
RUN apt-get update && \
apt-get upgrade -y

# Basic packages
RUN apt-get install -y sudo software-properties-common nano curl \
build-essential dos2unix gcc git git-flow libmcrypt4 libpcre3-dev apt-utils \
make python2.7-dev python-pip re2c supervisor unattended-upgrades whois vim zip unzip

# Install php & composer
RUN apt-get install -y php php-dev php-cli php-common php-curl php-gd \
php-gmp php-json php-ldap php-mysql php-odbc php-pspell php-readline \
php-recode php-sqlite3 php-tidy php-xml php-xmlrpc php-bcmath php-bz2 \
php-enchant php-fpm php-imap php-interbase php-intl php-mbstring \
php-mcrypt php-phpdbg php-soap php-sybase php-zip php-imagick \
php-redis php-apcu php-pear php-mongodb php-xdebug \
php-memcached php-pgsql nginx php-fpm && \
curl -sS https://getcomposer.org/installer | php && \
mv composer.phar /usr/local/bin/composer

# database install
RUN apt-get install -y sqlite3 libsqlite3-dev memcached redis-server && \
sed -i "s/daemonize yes/daemonize no/" /etc/redis/redis.conf

# Install Node
RUN curl --silent --location https://deb.nodesource.com/setup_5.x | bash - && \
apt-get install -y nodejs && \
npm install -g grunt-cli && \
npm install -g gulp && \
npm install -g bower

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
