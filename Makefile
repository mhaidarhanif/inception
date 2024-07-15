COMPOSE_PATH = srcs/docker-compose.yml

all: up

build:
	docker compose -f $(COMPOSE_PATH) up --build

up:
	docker compose -f $(COMPOSE_PATH) up -d

down:
	docker compose -f $(COMPOSE_PATH) down

clean:
	docker compose -f $(COMPOSE_PATH) down
	docker system prune -af

fclean:
	make clean
	rm -rfd /home/user/data/wordpress
	rm -rfd /home/user/data/mariadb
	mkdir /home/user/data/mariadb /home/user/data/wordpress

re:
	make fclean
	make all
