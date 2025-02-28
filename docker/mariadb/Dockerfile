# docker rm -f mariadb-container ; docker build -t mariadb .
# docker run --name mariadb-container mariadb
# 【別ターミナルで】docker exec -it mariadb-container bash
FROM debian:buster

RUN apt update && apt install -y mariadb-server gettext

COPY ./mariadb_entrypoint.sh /tmp/
RUN chmod +x /tmp/mariadb_entrypoint.sh
COPY ./my.cnf /etc/mysql/mariadb.conf.d/
COPY ./init.sql /tmp/

EXPOSE 3306

VOLUME /var/lib/mysql


RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
USER mysql

ENTRYPOINT ["/tmp/mariadb_entrypoint.sh"]