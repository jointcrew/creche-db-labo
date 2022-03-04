.PHONY: build up down destroy logs

build:
	docker-compose up --build -d

up:
	docker-compose up -d

start:
	yarn --cwd ./web dev

down:
	docker-compose down

destroy:
	docker-compose down --rmi all --volumes

logs:
	docker-compose logs -f