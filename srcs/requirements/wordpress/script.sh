#!/bin/bash
cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

./wp-cli.phar core download --allow-root

./wp-cli.phar config create \
  --dbname=${MYSQL_DATABASE} \
  --dbuser=${MYSQL_USER} \
  --dbpass=${MYSQL_PASSWORD} \
  --allow-root

./wp-cli.phar core install \
  --url=${SITE_URL} \
  --title=${SITE_TITLE} \
  --admin_user=${WP_ADMIN_LOGIN} \
  --admin_password=${WP_ADMIN_PASSWORD} \
  --admin_email=${WP_ADMIN_EMAIL} \
  --allow-root

./wp-cli.phar user create ${WP_USER} ${WP_EMAIL} \
  --user_pass=${WP_PASSWORD} --allow-root

php-fpm8.2 -F
