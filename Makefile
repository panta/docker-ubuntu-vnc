REPOSITORY?=panta/docker-ubuntu-vnc
NAME?=docker-ubuntu
TAG?=latest

DOCKER = docker

VERSION ?= $(shell git describe --tags)
GIT_VERSION ?= $(shell git --no-pager describe --tags --always --dirty)
GIT_DATE ?= $(shell git --no-pager show --date=short --format="%ad" --name-only | head -n 1 | awk '{print $1;}')
PROJECT_TAG ?= $(shell git describe --abbrev=0 --tags)
BUILD_DATE ?= $(shell date "+%Y%m%d-%H%M")
BUILD_HOST ?= $(shell hostname)

OK_COLOR=\033[32;01m
NO_COLOR=\033[0m

.PHONY: all
all: build push

.PHONY: build
build:
	@echo "$(OK_COLOR)==>$(NO_COLOR) Building $(REPOSITORY):$(TAG)"
	@docker build --rm -f Dockerfile -t $(REPOSITORY):$(TAG) .

.PHONY: run
run:
	@echo "$(OK_COLOR)==>$(NO_COLOR) Running $(REPOSITORY):$(TAG)"
	@docker run --rm -ti -p 5901:5901 --name $(NAME) $(REPOSITORY):$(TAG)

.PHONY: shell
shell:
	@echo "$(OK_COLOR)==>$(NO_COLOR) Running shell on $(NAME)"
	@docker exec -it $(NAME) bash

$(REPOSITORY)_$(TAG).tar: build
	@echo "$(OK_COLOR)==>$(NO_COLOR) Saving $(REPOSITORY):$(TAG) > $@"
	@docker save $(REPOSITORY):$(TAG) > $@

.PHONY: push
push: build
	@echo "$(OK_COLOR)==>$(NO_COLOR) Pushing $(REPOSITORY):$(TAG)"
	@docker push $(REPOSITORY):$(TAG)
