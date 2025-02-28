FROM debian:buster


# WordPress は PHPで動くWebアプリケーション なので、PHPの実行環境が必要
RUN apt install -y php7.4-fpm php7.4-mysqli php7.4-gd php7.4-curl \
php7.4-xml php7.4-mbstring php7.4-zip



COPY ./wordpress.sh /
COPY ./wp-config.php /
RUN chmod +x ./wordpress.sh


CMD [ "./wordpress.sh" ]
