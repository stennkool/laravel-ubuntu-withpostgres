FROM ubuntu:16.10 
MAINTAINER Stenn Kool <stennkool@gmail.com>

RUN apt-get update && apt-get -y install supervisor git nginx curl php-fpm php-mcrypt php-json php-pgsql php-curl unzip php-xml php-mbstring php-gd certbot composer npm nodejs nodejs-legacy && apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY php.ini /etc/php/7.0/fpm/php.ini

RUN /bin/rm /etc/nginx/sites-enabled/default

RUN /bin/mkdir /run/php

RUN locale-gen nl_NL

COPY laravel.conf /etc/nginx/sites-enabled/laravel

COPY nginx.conf /etc/nginx/nginx.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
