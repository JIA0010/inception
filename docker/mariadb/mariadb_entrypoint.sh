#!/bin/bash

envsubst < /tmp/init.sql > /tmp/init_substituited.sql

if [ ! -d /var/lib/mysql/mysql ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

exec mysqld