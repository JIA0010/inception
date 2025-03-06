
all: up

clean:
	rm -rf ~/data/db ~/data/web
	docker-compose -f ./docker/docker-compose.yml down --rmi all --volumes

bals:
	# すべてのコンテナを削除
	docker rm -f `docker ps -aq` | true
	# すべてのイメージを削除
	docker rmi -f `docker images -q` | true
	# すべてのネットワークを削除
	docker network prune -f | true
	# すべてのボリュームを削除
	docker volume rm `docker volume ls -q` | true
	# すべての未使用データを削除
	docker system prune -a -f --volumes | true
	# バインドマウントしたホストOSのボリュームを削除
	rm -rf ~/data/db ~/data/web

up: 
	mkdir -p ~/data/db ~/data/web
	docker-compose -f ./docker/docker-compose.yml up -d
	@sudo cp /etc/hosts /etc/hosts.backup
	@sudo chmod 777 /etc/hosts
	@sudo echo "127.0.0.1 cjia.42.fr" >> /etc/hosts
	@sudo chmod 644  /etc/hosts

down:
	docker-compose -f ./docker/docker-compose.yml down

stop:
	docker-compose -f ./docker/docker-compose.yml stop

start:
	docker-compose -f ./docker/docker-compose.yml start

status:
	docker-compose -f ./docker/docker-compose.yml  ps

restart:
	docker-compose -f ./docker/docker-compose.yml  restart

re: down up

RE: bals all

.PHONY: all up down stop start status restart re

