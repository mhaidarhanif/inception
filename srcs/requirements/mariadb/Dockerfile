FROM debian:trixie-slim

RUN apt update && apt upgrade -y && apt install -y mariadb-server mariadb-client gettext

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.

RUN mkdir /run/mysqld

COPY ./start.sh /
RUN chmod a+x /start.sh

CMD ["/start.sh"]
