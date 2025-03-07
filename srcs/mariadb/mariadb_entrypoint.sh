#!/bin/bash

envsubst < /tmp/init.sql > /tmp/init_substituited.sql

# 初期化をする調べる。envsubstの後の初期化しないといけない。
if [ ! -d /var/lib/mysql/mysql ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

exec mysqld