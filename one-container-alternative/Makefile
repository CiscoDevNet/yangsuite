build:
	docker build --target app_setup --platform linux/$$(uname -m | sed 's/arm64/arm64/g' | sed 's/x86_64/amd64/g') -t yangsuite-one-container .

run:
	docker run -itd --name yangsuite-one-container -v ./certificate:/certificate -v yangsuite-one-container-data:/ys-data --memory 4096m --memory-swap 4096m -p 443:443 -p 3000:3000 -p 8080:8080 -p 8086:8086 -p 8443:8443 -p 8480:8480 -p 9339:9339 -p 50051:50051 -p 50052:50052 -p 57344:57344 -p 57345:57345 -u developer yangsuite-one-container

start:
	docker start yangsuite-one-container

stop:
	docker stop yangsuite-one-container

rm: 
	-docker rm -f yangsuite-one-container

rm-volume:
	-docker volume rm yangsuite-one-container-data

follow:
	docker logs --follow yangsuite-one-container

debug:
	docker exec -it yangsuite-one-container sh -c '/build-assets/monitor_logs.sh'

cli:
	docker exec -it yangsuite-one-container /bin/bash

dev:
	$(MAKE) rm
	$(MAKE) rm-volume
	$(MAKE) build
	$(MAKE) run
	$(MAKE) follow
	# $(MAKE) debug