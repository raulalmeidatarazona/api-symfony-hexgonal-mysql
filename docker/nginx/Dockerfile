FROM nginx:1.19-alpine as basic
COPY docker/nginx/config/default.conf /etc/nginx/conf.d/default.conf

FROM basic as prod
COPY ./public /var/www/html
