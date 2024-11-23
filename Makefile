DOCKER_COMPOSE = docker-compose
SERVICE = twygo-api-web

start:
	$(DOCKER_COMPOSE) up -d

stop:
	$(DOCKER_COMPOSE) down

bash:
	docker exec -it $(SERVICE) bash

console:
	docker  exec -it $(SERVICE) rails console

test:
	docker exec -it $(SERVICE) rspec spec -fd

server:
	docker exec -it $(SERVICE) rails s -p 3000 -b '0.0.0.0'
