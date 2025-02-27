FROM debian:buster


RUN apt update && apt install -y curl

RUN apt install php-fpm php-mysql -y

COPY ./script.sh /
COPY ./wp-config.php /


CMD [ "/script.sh" ]
