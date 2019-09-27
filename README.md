# 架設高可用性RabbitMQ Clsuter 範例

1. 使用docker swarm cluster架設
2. haproxy代替swarm load balance
3. consul服務發現, 自動串起rabbitmq cluster

## How to change demo setting to yours?

1. change docker `registry url` to yours in `docker-compose.yml`.
2. change `rmq settings` to yours in `docker-compose.yml`.
3. change `network setting` to yours in all `yml files`.
3. change `rmq settings`, `docker node label settings` to yours in `Makefile`.

## how to build docker image

```
$ make build
```

## How to start demo

```
$ make run
```

