FROM debian:bullseye-slim

RUN apt update && \
  apt install -y mariadb-server

RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

COPY ./start.sh /
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.

RUN chmod +x /start.sh

EXPOSE 3306

ENTRYPOINT ["/start.sh"]
