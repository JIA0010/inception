# ビルドする
# docker build -t　タグ名 . 　-tは名前（タグ）をつける
#　コンテナを消すため
# docker rm -f `docker ps -aq`　-a 起動中でも全て出す    -q　IDだけ出す


FROM debian:stable

RUN apt update && apt install -y nginx openssl 
# RUN  apk update && apk add --no-cache nginx openssl

# SSL証明書の生成
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=JP/ST=Tokyo/L=Tokyo/O=42Tokyo/OU=42Tokyo/CN=cjia.42.fr"

    COPY ./nginx.conf /etc/nginx/nginx.conf
    # COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 443


CMD ["nginx", "-g", "daemon off;"]