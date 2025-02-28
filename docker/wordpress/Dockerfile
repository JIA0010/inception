FROM debian:buster


RUN apt update && apt install -y curl

RUN apt install php-fpm php-mysql -y

COPY ./wordpress.sh /
COPY ./wp-config.php /

RUN chmod +x /wordpress.sh

CMD [ "wordpress.sh" ]
