.PHONY: help build run 
help:
		@echo 'Welcome to Docker Swarm RabbitMQ Cluster'

build:
		@echo 'Now start to build !!!'
		docker network rm demo-net
		docker network create --attachable -d overlay demo-net
		docker-compose build
		docker-compose push

run:
		@echo 'Now start to run  !!!'
		docker node update --label-rm rabbitmq1 --label-rm consul --label-rm demo1 demo1 || true
		docker node update --label-rm rabbitmq2 --label-rm consul --label-rm demo2 demo2 || true
		docker node update --label-rm rabbitmq3 --label-rm consul --label-rm demo3 demo3 || true
		docker node update --label-add rabbitmq1=true --label-add consul=true demo1 || true
		docker node update --label-add rabbitmq2=true demo2 || true
		docker node update --label-add rabbitmq3=true demo3 || true
		docker stack deploy -c docker-compose-consul.yml consul
		@echo 'Now sleep 10s !!!'
		sleep 10
		docker node update --label-add consul=true demo2
		docker node update --label-add consul=true demo3
		@echo 'Now sleep 60s !!!'
		sleep 60
		docker stack deploy -c docker-compose.yml rmq
