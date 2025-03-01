#!/bin/bash
#ベースは今回はdebian。ワードプレスはdocker hubから取得したものによると（ドキュメントを読んでもだと思うが）/var/www/htmlにインストールされる。

# envsubst < /tmp/wp-config.php > /var/www/html/wp-config.php

set -e  # エラーハンドリング（エラー時に即停止）

mkdir -p /var/www/html

cd /var/www/html

# Download wp-cli。wp-cli.phar以外を消す（wp coreはからのディレクトリでしか動かない）
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Make it executable
chown root:root wp-cli.phar
chmod 755 wp-cli.phar

# Move it to /usr/local/bin/
mv wp-cli.phar /usr/local/bin/wp
rm -rf /var/www/html/*

# Download WordPress  ここが現在問題
if [ ! -f /var/www/html/wp-config.php ]; then
    # wp core download --allow-root
    wp core download --path=/var/www/html --locale=ja --allow-root
fi
# wp core download --allow-root

# Create wp-config.php(rename wp-config-sample.php)
# if [ -f /var/www/html/wp-config.php ]; then
#     mv /var/www/html/wp-config.php /var/www/html/wp-config.php
# fi
# mv /wp-config.php /var/www/html/wp-config.php # Copy wp-config.php to the right place



#いるかわからないが、wp-cliの設定を行う
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "wp-config.php が存在しません。新規作成します..."
    wp config create --path=/var/www/html --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="$DB_HOST" --allow-root
else
    echo "wp-config.php が既に存在します。設定を更新します..."
    wp config set DB_NAME "$DB_NAME" --path=/var/www/html --allow-root
    wp config set DB_USER "$DB_USER" --path=/var/www/html --allow-root
    wp config set DB_PASSWORD "$DB_PASSWORD" --path=/var/www/html --allow-root
    wp config set DB_HOST "$DB_HOST" --path=/var/www/html --allow-root
fi


# wp config create --path=/var/www/html \
#     --dbname=$DB_NAME \
#     --dbuser=$DB_USER \
#     --dbpass=$DB_PASSWORD \
#     --dbhost=$DB_HOST \
#     --allow-root

#download and install wordpress
wp core install --url=$WORDPRESS_URL --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --skip-email --allow-root

exec "$@"


# docker exec -it wordpress
