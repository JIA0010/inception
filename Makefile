
all: up

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
	docker-compose restart -f ./docker/docker-compose.yml