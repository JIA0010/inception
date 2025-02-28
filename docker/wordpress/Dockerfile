FROM debian:buster


# WordPress は PHPで動くWebアプリケーション なので、PHPの実行環境が必要
RUN apt update && apt install -y curl php php-mysql php-fpm


COPY ./wordpress.sh /tmp/
COPY ./wp-config.php /tmp/
RUN chmod +x /tmp/wordpress.sh


CMD [ "/tmp/wordpress.sh" ]
