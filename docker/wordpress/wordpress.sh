#!/bin/bash
#ベースは今回はdebian。ワードプレスはdocker hubから取得したものによると（ドキュメントを読んでもだと思うが）/var/www/htmlにインストールされる。

mkdir -p /var/www/html

cd /var/www/html

# Download wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Make it executable
chmod +x wp-cli.phar

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
sed -i "s/database_name_here/$DB_NAME/g" /var/www/html/wp-config.php
sed -i "s/username_here/$DB_USER/g" /var/www/html/wp-config.php
sed -i "s/password_here/$DB_PASSWORD/g" /var/www/html/wp-config.php

#download and install wordpress
wp core install --url=$WORDPRESS_URL --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --skip-email --allow-root

exec "$@"