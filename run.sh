#!/bin/sh
echo "copying data"
git clone -b release ${repository} /var/www/laravel/
echo "pulling composer"
cd /var/www/laravel
composer update
echo "setting permissions"
chmod -R 777 /var/www/laravel/storage
chmod -R 777 /var/www/laravel/bootstrap/cache
echo "running supervisord"
/usr/bin/supervisord
