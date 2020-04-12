FROM php:7.4.4-fpm

# Update bash profile
COPY ./docker/.profile /root/.profile
COPY ./docker/.profile /root/.bashrc

# Install stuff
RUN apt-get update
RUN apt-get install -my --no-install-recommends libonig-dev
RUN apt-get install -my --no-install-recommends libssl-dev
RUN apt-get install -my --no-install-recommends libxml2
RUN apt-get install -my --no-install-recommends libxml2-dev
RUN apt-get install -my --no-install-recommends libxpm-dev
RUN apt-get install -my --no-install-recommends libzip-dev
RUN apt-get install -my --no-install-recommends openssl
RUN apt-get install -my --no-install-recommends unzip
RUN apt-get install -my --no-install-recommends libjpeg-dev
RUN apt-get install -my --no-install-recommends libpng-dev
RUN apt-get clean
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install iconv
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install opcache
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install xmlrpc
RUN docker-php-ext-install zip
RUN docker-php-ext-install mysqli;
RUN pecl install xdebug-2.9.2;
RUN docker-php-ext-enable xdebug;

COPY ./docker/php/php-custom-config.ini /usr/local/etc/php/conf.d/php-custom-config.ini
COPY ./docker/php/php-config-dev.ini /usr/local/etc/php/conf.d/php-env-config.ini
COPY ./docker/php/fpm-www.conf /usr/local/etc/php-fpm.d/www.conf
