FROM debian:12.8


# WordPress は PHPで動くWebアプリケーション なので、PHPの実行環境が必要

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
    # envsubst は gettext パッケージに含まれている



COPY ./www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY ./wordpress.sh /tmp/
COPY ./wp-config.php /tmp/

RUN chmod +x /tmp/wordpress.sh

EXPOSE 9000

ENTRYPOINT [ "/tmp/wordpress.sh" ]
# CMD ["tail", "-f", "/dev/null"]