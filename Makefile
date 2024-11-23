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

sidekiq:
	docker	exec -it $(SERVICE) bundle exec sidekiq
