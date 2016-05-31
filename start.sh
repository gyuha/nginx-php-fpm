#!/bin/bash

if [ ! -z "$NGINX_APP_PATH" ]; then
	sed -i -e "s|^\troot.*;|\troot $NGINX_APP_PATH;|g" /etc/nginx/sites-available/default.conf
fi

if [ ! -z "$NGINX_SERVER_NAME" ]; then
	sed -i -e "s|^\t# server_name.*;|\tserver_name $NGINX_SERVER_NAME;|g" /etc/nginx/sites-available/default.conf
	sed -i -e "s|^\tserver_name.*;|\tserver_name $NGINX_SERVER_NAME;|g" /etc/nginx/sites-available/default.conf
fi

if [ ! -z "$NGINX_SSL_PATH" ]; then
	sed -i -e "s|#ssl\s*on;|ssl on;|" /etc/nginx/sites-available/default.conf
	sed -i -e "s|#ssl_certificate\s*.*;|ssl_certificate $NGINX_SSL_CERTIFICATE;|" /etc/nginx/sites-available/default.conf
	sed -i -e "s|#ssl_certificate_key\s*.*;|ssl_certificate_key $NGINX_SSL_CERTIFICATE_KEY;|" /etc/nginx/sites-available/default.conf
fi

# Start supervisord and services
/usr/bin/supervisord
