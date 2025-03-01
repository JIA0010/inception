#!/bin/bash
#ベースは今回はdebian。ワードプレスはdocker hubから取得したものによると（ドキュメントを読んでもだと思うが）/var/www/htmlにインストールされる。

envsubst < /tmp/wp-config.php > /var/www/html/wp-config.php

set -e  # エラーハンドリング（エラー時に即停止）

mkdir -p /var/www/html

cd /var/www/html

# Download wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Make it executable
chown root:root wp-cli.phar
chmod 755 wp-cli.phar

# Move it to /usr/local/bin/
mv wp-cli.phar /usr/local/bin/wp

# Download WordPress
if [ ! -f wp-config-sample.php ]; then
    # wp core download --allow-root
    wp core download --path=/var/www/html --locale=ja --allow-root
fi
# wp core download --allow-root

# Create wp-config.php(rename wp-config-sample.php)
if [ -f /var/www/html/wp-config-sample.php ]; then
    mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
fi
# mv /wp-config.php /var/www/html/wp-config.php # Copy wp-config.php to the right place


# # Replace database settings
# sed -i "s/database_name_here/$DB_NAME/g" /var/www/html/wp-config.php
# sed -i "s/username_here/$DB_USER/g" /var/www/html/wp-config.php
# sed -i "s/password_here/$DB_PASSWORD/g" /var/www/html/wp-config.php

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






# 可能性
# wp-cli のキャッシュフォルダの権限を修正：

# mkdir -p /root/.wp-cli
# chown -R root:root /root/.wp-cli
# chmod -R 755 /root/.wp-cli