#!/bin/bash
set -e

mkdir -p /run/php/
cd /var/www/html

# Check if wp-config.php exists and download WordPress if not
if [ -f /var/www/html/wp-config.php ]; then
    echo "wp-config.php already exists. Skipping creation."
else
  echo "Downloading wp-cli.phar"
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar

  echo "Downloading WordPress core files"
  ./wp-cli.phar core download --allow-root

	sleep 5

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
    --admin_email="${WP_ADMIN_EMAIL}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --skip-email \
    --allow-root

  echo "Creating additional user"
  ./wp-cli.phar user create "${WP_USER}" "${WP_USER_EMAIL}" \
    --user_pass="${WP_USER_PASSWORD}" --role=author --allow-root
fi

echo "Starting PHP-FPM"
php-fpm7.4 -F
