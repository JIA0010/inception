FROM debian:buster


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
    sendmail
    # envsubst は gettext パッケージに含まれています




COPY ./wordpress.sh /tmp/
COPY ./wp-config.php /tmp/
RUN chmod +x /tmp/wordpress.sh

EXPOSE 9000

ENTRYPOINT [ "/tmp/wordpress.sh" ]
# CMD ["tail", "-f", "/dev/null"]

# CMD [ "/tmp/wordpress.sh" ]
CMD ["php-fpm7.4", "-F"]
