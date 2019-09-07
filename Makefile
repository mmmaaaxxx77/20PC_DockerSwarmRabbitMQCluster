build:
	docker network create --attachable -d overlay demo-net
	docker-compose build
	docker-compose push

run:
	docker node update --label-rm consul demo2
	docker node update --label-rm consul demo3
	docker stack deploy -c docker-compose.yml rmq
	sleep 30
	docker node update --label-add consul=true demo2
	docker node update --label-add consul=true demo3