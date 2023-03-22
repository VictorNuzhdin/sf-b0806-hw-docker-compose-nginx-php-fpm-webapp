FROM php:8-fpm-alpine

## Install Tools and Build Dependencies
## oniguruma \
RUN apk update \
    && apk add --no-cache \
         curl \
         wget \
         git \
	&& apk add --update linux-headers \
    && apk add --no-cache \		 
		 freetype-dev libjpeg-turbo-dev libpng-dev oniguruma-dev libzip-dev libmcrypt-dev pcre-dev autoconf g++ gcc libtool make \
		 ${PHPIZE_DEPS} \
	&& pecl install xdebug \
    && pecl install mcrypt-1.0.6 \
	&& rm -rf /var/lib/apt/lists/*

## Install/Enable PHP-extension and remove unnecessary tools
#RUN docker-php-ext-install -j$(nproc) iconv mbstring mysqli pdo_mysql zip \
RUN docker-php-ext-install -j$(nproc) mbstring mysqli pdo_mysql zip \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-enable mcrypt \
	&& docker-php-ext-enable xdebug \
	&& docker-php-source delete \
	&& apk del --purge freetype-dev libjpeg-turbo-dev libpng-dev oniguruma-dev libzip-dev libmcrypt-dev pcre-dev autoconf gcc make linux-headers

## Instal Composer (PHP package manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

## Set PHP configuration file
ADD ./configs/php/php.ini /usr/local/etc/php/conf.d/40-custom.ini

## Set workdir
WORKDIR /var/www/html

## Run php-fpm
CMD ["php-fpm"]
