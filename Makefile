build:
	docker-compose up --build -d
	yarn --cwd ./web install

up:
	docker-compose up -d

start:
	yarn --cwd ./web dev

down:
	docker-compose down

destroy:
	docker-compose down --rmi all --volumes
	rm -rf ./web/node_modules

logs:
	docker-compose logs -f