# Ngnix & PHP-fpm

## 이미지 받기
```
docker pull gyuha/nginx-php-fpm:lastest
```

## 환경변수 설정 하기
```
NGINX_SERVER_NAME="sample.com"
NGINX_ROOT_PATH="/opt/wwwroot"
NGINX_APP_PATH=${NGINX_ROOT_PATH}"/application/public"
NGINX_SSL_PATH="/opt/ssl"
NGINX_SSL_CERTIFICATE="ssl-unified.crt"
NGINX_SSL_CERTIFICATE_KEY="ssl.key"
```

## 실행하기
```
docker \
  run \
  --detach \
  --env NGINX_SERVER_NAME=${NGINX_SERVER_NAME} \
  --volume ${NGINX_ROOT_PATH}:/opt/wwwroot \
  --env NGINX_APP_PATH=${NGINX_APP_PATH} \
  --name nginx-php-fpm \
  --publish 80:80 \
  --publish 433:433 \
  --restart=always
  gyuha/nginx-php-fpm;
```

### SSL 지정하기
```
docker \
  run \
  --detach \
  --env NGINX_SERVER_NAME=${NGINX_SERVER_NAME} \
  --volume ${NGINX_ROOT_PATH}:/opt/wwwroot \
  --env NGINX_APP_PATH=${NGINX_APP_PATH} \
  --volume ${NGINX_SSL_PATH}:/etc/nginx/ssl \
  --env NGINX_SSL_CERTIFICATE=${NGINX_SSL_CERTIFICATE} \
  --env NGINX_SSL_CERTIFICATE_KEY=${NGINX_SSL_CERTIFICATE_KEY} \
  --name nginx-php-fpm \
  --publish 80:80 \
  --publish 433:433 \
  --restart=always
  gyuha/nginx-php-fpm;
```

## Docker build
```
docker build -t nginx-php-fpm .
```

without cache
```
docker build -t nginx-php-fpm --no-cache .
```

