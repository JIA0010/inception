DCOMPOSE = docker-compose -f ./srcs/docker-compose.yml

all: up

bals:
	# すべてのコンテナを停止
	docker stop `docker ps -qa` | true
	# すべてのコンテナを削除
	docker rm `docker ps -qa` | true
	# すべてのイメージを削除
	docker rmi `docker images -qa` | true
	# すべてのボリュームを削除
	docker volume rm `docker volume ls -q` | true
	# すべてのネットワークを削除
	docker network rm `docker network ls -q` | true
	# バインドマウントしたホストOSのボリュームを削除
	@sudo rm -rf ~/data/db ~/data/web

up: 
	@sudo mkdir -p ~/data/db ~/data/web
	$(DCOMPOSE) up -d
# hostsファイルに追記（名前解決）
	@sudo cp /etc/hosts /etc/hosts.backup
	@sudo chmod 777 /etc/hosts
	@sudo echo "127.0.0.1 cjia.42.fr" >> /etc/hosts
	@sudo chmod 644  /etc/hosts

# --rmi all --volumes を付けるとイメージやボリュームも削除可能
down:
	$(DCOMPOSE) down --rmi all --volumes
	@sudo mv /etc/hosts.backup /etc/hosts

stop:
	$(DCOMPOSE) stop

start:
	$(DCOMPOSE) start

status:
	$(DCOMPOSE)  ps

restart:
	$(DCOMPOSE)  restart

re: down up

.PHONY: all up down stop start status restart re bals

