DOCKER_IMAGE_NAME = advneture_channel

build:
	docker build -t ${USER}/${DOCKER_IMAGE_NAME} .

run:
	docker run -v `pwd`:/${DOCKER_IMAGE_NAME} -d ${USER}/${DOCKER_IMAGE_NAME}
#	docker run -d ${USER}/${DOCKER_IMAGE_NAME}

stop:
	docker stop ${DOCKER_IMAGE_NAME}

console:
	docker run -v .:/${DOCKER_IMAGE_NAME} -it ${USER}/${DOCKER_IMAGE_NAME} bash

.PHONY: build


#docker run --name ${DOCKER_IMAGE_NAME} -v `pwd`:/${DOCKER_IMAGE_NAME} -d ${USER}/${DOCKER_IMAGE_NAME}
