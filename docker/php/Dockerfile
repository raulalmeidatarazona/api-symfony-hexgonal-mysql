FROM php:8.1-fpm-alpine as base

ENV PROJECT_DIR /var/app/
RUN mkdir $PROJECT_DIR

# Install packages and PHP extensions
RUN apk add --no-cache --virtual .ext-deps postgresql-dev bash libzip-dev openssl-dev rabbitmq-c-dev $PHPIZE_DEPS && \
	pecl install amqp-1.11.0 && \
	docker-php-ext-configure pdo_mysql && \
	docker-php-ext-enable amqp && \
	docker-php-ext-install pdo_mysql pdo sockets && \
    docker-php-ext-install opcache && \
    apk add --update linux-headers

ENV PATH /var/app/bin:/var/app/vendor/bin:$PATH
WORKDIR $PROJECT_DIR

COPY --chown=www-data:www-data ./composer.json ./composer.lock ./symfony.lock $PROJECT_DIR
# Install and update composer
RUN curl https://getcomposer.org/composer.phar -o /usr/bin/composer && chmod +x /usr/bin/composer
RUN composer self-update
## Install Symfony binary
RUN apk add --no-cache bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.alpine.sh' | bash
RUN apk add symfony-cli
COPY . .

FROM base as dev
RUN apk add --no-cache git  &&\
    pecl install xdebug && \
    docker-php-ext-enable xdebug
RUN mkdir -p $PROJECT_DIR/var/cache/dev && chown -R www-data:www-data $PROJECT_DIR/var/cache/dev
COPY docker/php/php_dev.ini /usr/local/etc/php/php.ini
COPY docker/php/www.conf /usr/local/etc/php-fpm.d/www.conf
RUN composer install --no-scripts
COPY --chown=www-data:www-data docker/php/ /var/app/php
RUN chown www-data:www-data -R /var/app && chmod g+w -R /var/app

FROM base as prod
# Set production environment
ENV APP_ENV=prod
ENV APP_DEBUG=0
ENV COMPOSER_ALLOW_SUPERUSER=1
WORKDIR $PROJECT_DIR
RUN composer install --no-scripts
COPY .env .
# Clear cache
RUN composer dump-autoload --no-dev --optimize && \
    composer dump-env prod && \
    /var/app/bin/console cache:warmup --no-debug && \
    rm -rf var/cache/dev var/cache/test var/cache/prod
# Change permissions on writable directories
RUN chmod -R 777 var/log var/cache
# Configure PHP
COPY dockerconfig/php_prod.ini /usr/local/etc/php/php.ini
COPY dockerconfig/www.conf /usr/local/etc/php-fpm.d/www.conf
# Copy application files
COPY --chown=www-data:www-data docker/php/ /var/app/php
RUN chown www-data:www-data -R /var/app && chmod g+w -R /var/app
