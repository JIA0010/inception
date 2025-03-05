FROM debian:stable


# WordPress は PHPで動くWebアプリケーション なので、PHPの実行環境が必要
# RUN apt update && apt install -y curl php php-mysql php-fpm

RUN apt update && apt install -y \
    curl \
    php \
    php-fpm \
    php-mysql \
    php-mbstring \
    php-xml \
    php-curl \
    php-zip \
    gettext \
    sendmail \
    mariadb-client
    # envsubst は gettext パッケージに含まれています



COPY ./www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY ./wordpress.sh /tmp/
COPY ./wp-config.php /tmp/
# COPY ./ /var/www/html/path/to/css/files  # CSSファイルをコピー

RUN chmod +x /tmp/wordpress.sh
# RUN chmod -R 755 /var/www/html/path/to/css/files

EXPOSE 9000

ENTRYPOINT [ "/tmp/wordpress.sh" ]
# CMD ["tail", "-f", "/dev/null"]

# CMD [ "/tmp/wordpress.sh" ]
# CMD ["php-fpm", "-F"]
