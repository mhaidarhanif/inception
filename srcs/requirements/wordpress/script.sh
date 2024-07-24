#!/bin/bash
set -e

cd /var/www/html

# Check if wp-config.php exists and download WordPress if not
if [ ! -f wp-config.php ]; then
  echo "Downloading wp-cli.phar"
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar

  echo "Downloading WordPress core files"
  ./wp-cli.phar core download --allow-root

  echo "Creating wp-config.php"
  ./wp-cli.phar config create \
    --dbname="${MYSQL_DATABASE}" \
    --dbuser="${MYSQL_USER}" \
    --dbpass="${MYSQL_PASSWORD}" \
    --dbhost=mariadb:3306 \
    --allow-root

  echo "Installing WordPress"
  ./wp-cli.phar core install \
    --url="${DOMAIN_NAME}" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN}" \
    --admin_password="${WP_PASSWORD}" \
    --admin_email="${WP_EMAIL}" \
    --skip-email \
    --allow-root

  echo "Creating additional user"
  ./wp-cli.phar user create "${WP_USER}" "${WP_USER_EMAIL}" \
    --user_pass="${WP_USER_PASSWORD}" --role=author --allow-root
else
  echo "wp-config.php already exists. Skipping download and configuration."
fi

echo "Starting PHP-FPM"
php-fpm7.4 -F
