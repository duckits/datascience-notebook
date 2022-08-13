
APP_NAME ?= duckits/datascience-notebook
APP_TAG ?= $(shell git rev-parse --short HEAD)

.DEFAULT_GOAL := run

build:
	docker build -t ${APP_NAME}:$(APP_TAG) .

push: build
	docker push ${APP_NAME}:$(APP_TAG)

run: build
	docker run -it --rm \
		--name "$(APP_NAME)" \
		--publish 8888:8888 \
		--volume "$(shell pwd)/notebooks":/home/jovyan/ \
		$(APP_NAME):$(APP_TAG)
