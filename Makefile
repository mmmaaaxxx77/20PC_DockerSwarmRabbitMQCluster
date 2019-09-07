build:
	docker network create --attachable -d overlay demo-net
	docker-compose build
	docker-compose push

run:
	docker node update --label-rm consul demo2 || true
	docker node update --label-rm consul demo3 || true
	docker stack deploy -c docker-compose-consul.yml consul
	sleep 60
	docker node update --label-add consul=true demo2
	docker node update --label-add consul=true demo3
	docker stack deploy -c docker-compose.yml rmq