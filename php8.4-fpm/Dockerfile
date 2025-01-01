FROM php:8.4-fpm-alpine3.21

ARG WWWGROUP

WORKDIR /var/www

ENV DEBIAN_FRONTEND noninteractive
#ENV TZ=UTC

COPY openssl.cnf /etc/ssl/openssl.cnf

#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN addgroup -S 1000 && adduser -S fabricadolivro --uid 1000 -G 1000

RUN apk update --no-cache && \
    apk upgrade &&  \
    apk add \
    autoconf \
    bash \
    build-base \
    curl \
    ghostscript \
    git \
    gmp-dev \
    less \
    librdkafka \
    librdkafka-dev \
    libzip-dev \
    mysql-client \
    nano \
    oniguruma-dev \
    postgresql-dev \
    supervisor \
    unzip \
    vim \
    zip \
    zlib-dev

RUN docker-php-ext-install bcmath
RUN docker-php-ext-install exif
RUN docker-php-ext-install gmp
RUN docker-php-ext-install intl
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-install pdo pdo_pgsql pgsql
RUN docker-php-ext-install zip

RUN pecl install redis && \
    rm -rf /tmp/pear && \
    docker-php-ext-enable redis

RUN apk add --update linux-headers && \
    apk add --no-cache $PHPIZE_DEPS && \
#    apk add --no-cache autoconf dpkg-dev dpkg file g++ gcc libc-dev make pkgconf re2c && \
    pecl install -o -f xdebug && \
    docker-php-ext-enable xdebug

RUN apk add --no-cache libjpeg-turbo libjpeg-turbo-dev jpeg-dev freetype-dev libpng libpng-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd && \
    apk del libpng-dev

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/

RUN pecl install mongodb && \
    echo "extension=mongodb.so" > $PHP_INI_DIR/conf.d/mongo.ini

RUN pecl install rdkafka && \
    echo "extension=rdkafka.so" > /usr/local/etc/php/conf.d/rdkafka.ini

RUN rm -rf /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

USER root
COPY my-aliases.sh /etc/profile.d/alias.sh
COPY conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY conf.d/error_reporting.ini /usr/local/etc/php/conf.d/error_reporting.ini
COPY conf.d/php.ini /usr/local/etc/php/conf.d/99-sail.ini
COPY www.conf /usr/local/etc/php-fpm.d/www.conf
COPY start-container /usr/local/bin/start-container
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chmod +x /usr/local/bin/start-container

RUN chown -R fabricadolivro:1000 /var/www
USER fabricadolivro

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]