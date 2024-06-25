COMPOSE_PATH = srcs/docker-compose.yml

all: up

up:
	docker compose -f $(COMPOSE_PATH) up -d

down:
	docker compose -f $(COMPOSE_PATH) down

clean:
	docker compose -f $(COMPOSE_PATH) down
	docker system prune -af

clean_files:
	make clean
	rm -rfd ./data/wordpress
	rm -rfd ./data/mariadb
	mkdir ./data/mariadb ./data/wordpress

re:
	make fclean
	make all
