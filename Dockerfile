FROM php:8.2-apache
MAINTAINER Vinod "vinod@scopeindia.org"
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo pdo_mysql
COPY src/ /var/www/html/
WORKDIR /var/www/html
COPY composer.json composer.lock ./
RUN composer install --no-autoloader --no-scripts
RUN chown -R www-data:www-data /var/www/html
EXPOSE 80
CMD ["apache2-foreground"]