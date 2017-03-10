#!/bin/sh
echo "copying data"
mkdir /var/www/laravel
cd /var/www/laravel
git init
git remote add origin ${repository}
git fetch
git checkout release
echo "pulling composer"
echo "setting laravel config file"
cp /var/env/.env /var/www/laravel/.env
composer update
echo "setting permissions"
chmod -R 777 /var/www/laravel/storage
chmod -R 777 /var/www/laravel/bootstrap/cache
echo "running supervisord"
/usr/bin/supervisord
