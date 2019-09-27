build:
    # clear network setting
    docker network rm demo-net
    # docker build img
	docker network create --attachable -d overlay demo-net
	docker-compose build
	docker-compose push

run:
    # clear labels
    docker node update --label-rm rabbitmq1 --label-rm consul --label-rm demo1 || true
    docker node update --label-rm rabbitmq2 --label-rm consul --label-rm demo2 || true
    docker node update --label-rm rabbitmq3 --label-rm consul --label-rm demo3 || true

    # add rabbitmq label
    docker node update --label-add rabbitmq1=true --label-add consul=true demo1 || true
    docker node update --label-add rabbitmq2=true demo2 || true
    docker node update --label-add rabbitmq3=true demo3 || true

    # start demo1 consul
	docker stack deploy -c docker-compose-consul.yml consul
	sleep 10

	# start demo2 demo3 consul
	docker node update --label-add consul=true demo2
	docker node update --label-add consul=true demo3
	sleep 60

	# start rabbitmq and haproxy
	docker stack deploy -c docker-compose.yml rmq
