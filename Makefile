DOCKER_COMPOSE = docker-compose
SERVICE = twygo-api-web

bash:
	$(DOCKER_COMPOSE) exec $(SERVICE) bash

start:
	$(DOCKER_COMPOSE) up -d

stop:
	$(DOCKER_COMPOSE) down

server:
	docker  exec $(SERVICE) bin/rails s -b 0.0.0.0 -p 3000

console:
	docker  exec -it $(SERVICE) rails console
