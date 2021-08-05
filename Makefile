.PHONY: test check clean build dist all

ENV_DIST_VERSION = 1.0.0
ROOT_DOCKER_CONTAINER ?= cgo-compile-test
# see https://hub.docker.com/_/golang?tab=tags&page=1&ordering=last_updated&name=1.16.2
ROOT_DOCKER_IMAGE_PARENT_NAME ?= golang
ROOT_DOCKER_IMAGE_PARENT_TAG ?= 1.16.2-buster

default: cgoBuildDarwinAmd64

clean:
	-@rm *.a *.o

cgoBuildDarwinAmd64: clean
	CGO_ENABLED=1 GOOS=darwin GOARCH=amd64 \
	go build -ldflags "-w" -x -v -buildmode=c-archive \
	-o test.a
	@echo ""
	file test.a

cgoCC: cgoBuildDarwinAmd64
	cc -c -o testc.o test.c
	ar rs test.a testc.o

dockerCgoBuildDarwinAmd64:
	ROOT_DOCKER_CONTAINER=$(ROOT_DOCKER_CONTAINER) \
	ROOT_DOCKER_IMAGE_NAME=$(ROOT_DOCKER_IMAGE_PARENT_NAME) \
	ROOT_DOCKER_IMAGE_TAG=$(ROOT_DOCKER_IMAGE_PARENT_TAG) \
	docker-compose up -d
	-sleep 5
	docker logs $(ROOT_DOCKER_CONTAINER) -f

dockerStop:
	ROOT_DOCKER_CONTAINER=$(ROOT_DOCKER_CONTAINER) \
	ROOT_DOCKER_IMAGE_NAME=$(ROOT_DOCKER_IMAGE_NAME) \
	ROOT_DOCKER_IMAGE_TAG=$(ROOT_DOCKER_IMAGE_TAG) \
	ENV_DIST_VERSION=$(ENV_DIST_VERSION) \
	-docker-compose stop

dockerPrune: dockerStop
	ROOT_DOCKER_CONTAINER=$(ROOT_DOCKER_CONTAINER) \
	ROOT_DOCKER_IMAGE_NAME=$(ROOT_DOCKER_IMAGE_NAME) \
	ROOT_DOCKER_IMAGE_TAG=$(ROOT_DOCKER_IMAGE_TAG) \
	ENV_DIST_VERSION=$(ENV_DIST_VERSION) \
	docker-compose rm -f $(ROOT_DOCKER_CONTAINER)
	docker network prune
	docker volume prune
