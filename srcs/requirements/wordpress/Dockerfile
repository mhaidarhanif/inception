FROM debian:bullseye-slim

RUN apt update && apt upgrade -y && apt install -y php-fpm php-mysql php-mysqli curl

COPY www.conf /etc/php/7.4/fpm/pool.d/.
COPY script.sh .

RUN chmod +x script.sh

EXPOSE 9000

CMD ["./script.sh"]
