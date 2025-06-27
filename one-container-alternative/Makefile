# Detect container runtime (docker or podman)
DOCKER_EXISTS := $(shell command -v docker 2> /dev/null)
PODMAN_EXISTS := $(shell command -v podman 2> /dev/null)

ifdef DOCKER_EXISTS
    CONTAINER_CMD = docker
else ifdef PODMAN_EXISTS
    CONTAINER_CMD = podman
else
    CONTAINER_CMD = echo "Error: Neither docker nor podman is installed. Please install either docker or podman to continue." && exit 1 &&
endif

check-runtime:
	@echo "Using container runtime: $(CONTAINER_CMD)"

build: check-runtime
	$(CONTAINER_CMD) build --target app_setup --platform linux/$$(uname -m | sed 's/arm64/arm64/g' | sed 's/x86_64/amd64/g') -t yangsuite-one-container .

run: check-runtime
	$(CONTAINER_CMD) run -itd --name yangsuite-one-container -v ./certificate:/certificate -v yangsuite-one-container-data:/ys-data --memory 4096m --memory-swap 4096m -p 8480:8480 -p 57500:57500 -p 57501:57501 -u root yangsuite-one-container

start: check-runtime
	$(CONTAINER_CMD) start yangsuite-one-container

stop: check-runtime
	$(CONTAINER_CMD) stop yangsuite-one-container

rm: check-runtime
	-$(CONTAINER_CMD) rm -f yangsuite-one-container

rm-volume: check-runtime
	-$(CONTAINER_CMD) volume rm yangsuite-one-container-data

follow: check-runtime
	$(CONTAINER_CMD) logs --follow yangsuite-one-container

debug: check-runtime
	$(CONTAINER_CMD) exec -it yangsuite-one-container sh -c '/build-assets/monitor_logs.sh'

cli: check-runtime
	$(CONTAINER_CMD) exec -it yangsuite-one-container /bin/bash

dev:
	$(MAKE) rm
	$(MAKE) rm-volume
	$(MAKE) build
	$(MAKE) run
	$(MAKE) follow
	# $(MAKE) debug