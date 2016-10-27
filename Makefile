# This is just a Makefile for dealing with docker containers, you can ignore it, it just works :)
REDIS_CONTAINER_NAME = adventure-channel-redis
PROJECT_NAME = adventure-channel

boot-containers-dependency:
	(docker start ${REDIS_CONTAINER_NAME}) || \
  docker run --name ${REDIS_CONTAINER_NAME} \
    -v /data/adventure-channel-db:/data \
    -p 6379:6379 \
    -d redis:3.2.4 redis-server --appendonly yes
	(docker start ${PROJECT_NAME}-ircd) || \
  docker run --name ${PROJECT_NAME}-ircd \
    -p 6667:6667 \
    thenotary/ircd-docker


