FROM ubuntu:16.10 
MAINTAINER Stenn Kool <stennkool@gmail.com>

RUN apt-get update && apt-get -y install supervisor git nginx curl php-fpm php-mcrypt php-json php-pgsql php-curl unzip php-xml php-mbstring php-gd certbot vim php-mysql composer npm nodejs nodejs-legacy && apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY php.ini /etc/php/7.0/fpm/php.ini

RUN /bin/rm /etc/nginx/sites-enabled/default

RUN /bin/mkdir /run/php

RUN /bin/mkdir /root/.ssh/

COPY laravel /var/www/

WORKDIR /var/www/laravel

RUN locale-gen nl_NL

COPY laravel.conf /etc/nginx/sites-enabled/laravel

COPY nginx.conf /etc/nginx/nginx.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN /bin/chmod -R 777 /var/www/laravel/storage

RUN /bin/chmod -R 777 /var/www/laravel/bootstrap/cache

RUN /usr/bin/composer update

EXPOSE 80

CMD /usr/bin/supervisord
