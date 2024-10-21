all:
	$(MAKE) build
	$(MAKE) run

build:
	$(MAKE) clean
	docker build --target app_setup --platform linux/$$(uname -m | sed 's/arm64/arm64/g' | sed 's/x86_64/amd64/g') -t yangsuite .

run:
	$(MAKE) clean
	docker run -itd --rm --name yangsuite -p 80:80 -p 443:443 -p 3000:3000 -p 8080:8080 -p 8086:8086 -p 9339:9339 -p 50052:50052 -p 50051:50051 -p 57344:57344 -p 57345:57345 -u developer yangsuite

clean: 
	docker rm -f yangsuite

follow:
	docker logs --follow yangsuite

cli:
	docker exec -it yangsuite /bin/bash