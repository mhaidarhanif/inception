FROM debian:bullseye-slim

RUN apt update && apt upgrade -y && apt install -y php-fpm php-mysqli curl

COPY www.conf /etc/php/8.2/fpm/pool.d/.
COPY wp-config.php /var/www/html/wp-config.php
COPY script.sh .

RUN chmod +x script.sh

CMD ["./script.sh"]
