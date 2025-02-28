
all: up

clean:
	docker-compose -f ./docker/docker-compose.yml down --rmi all --volumes

bals:
	# すべてのコンテナを削除
	docker rm -f `docker ps -aq` | true
	# すべてのイメージを削除
	docker rmi -f `docker images -q` | true
	# すべてのネットワークを削除
	docker network prune -f | true
	# すべてのボリュームを削除
	docker volume prune -f | true
	# すべての未使用データを削除
	docker system prune -a -f --volumes | true

up:
	docker-compose -f ./docker/docker-compose.yml up -d

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

.PHONY: all up down stop start status restart re

