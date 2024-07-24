COMPOSE_PATH = srcs/docker-compose.yml
MARIADB_VOLUME = /Users/user/data/mariadb
WORDPRESS_VOLUME = /Users/user/data/wordpress

all: up

build:
	mkdir -p $(MARIADB_VOLUME) $(WORDPRESS_VOLUME)
	docker compose -f $(COMPOSE_PATH) up --build

up:
	mkdir -p $(MARIADB_VOLUME) $(WORDPRESS_VOLUME)
	docker compose -f $(COMPOSE_PATH) up

down:
	docker compose -f $(COMPOSE_PATH) down

clean:
	docker compose -f $(COMPOSE_PATH) down
	docker volume prune -f
	docker system prune -af
	rm -rf $(MARIADB_VOLUME) $(WORDPRESS_VOLUME)
	rm -rf /Users/user/data/
	docker ps -aq | xargs -r sudo docker rm -f

fclean:
	make clean
	rm -rfd /Users/user/data/wordpress
	rm -rfd /Users/user/data/mariadb
	mkdir /Users/user/data/mariadb /Users/user/data/wordpress

re:
	make fclean
	make all
