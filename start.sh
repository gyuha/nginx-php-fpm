#!/bin/bash

# Tweak nginx to match the workers to cpu's
procs=$(cat /proc/cpuinfo |grep processor | wc -l)
sed -i -e "s/worker_processes 5/worker_processes $procs/" /etc/nginx/nginx.conf

if [ ! -z "$NGINX_APP_PATH" ]; then
	sed -i -e "s/\/opt\/wwwroot/$NGINX_APP_PATH/" /etc/nginx/sites-available/default.conf
fi

if [ ! -z "$NGINX_SERVER_NAME" ]; then
	sed -i -e "s/#server_name localhost;/server_name $NGINX_SERVER_NAME;/" /etc/nginx/sites-available/default.conf
fi

if [ ! -z "$NGINX_SSL_PATH" ]; then
	sed -i -e "s/#ssl\s*on;/ssl on;/" /etc/nginx/sites-available/default.conf
	sed -i -e "s/#ssl_certificate\s*.*;/ssl_certificate $NGINX_SSL_CERTIFICATE;/" /etc/nginx/sites-available/default.conf
	sed -i -e "s/#ssl_certificate_key\s*.*;/ssl_certificate_key $NGINX_SSL_CERTIFICATE_KEY;/" /etc/nginx/sites-available/default.conf
fi

php5-fpm --allow-to-run-as-root --nodaemonize --fpm-config /etc/php5/fpm/php-fpm.conf &
exec nginx
