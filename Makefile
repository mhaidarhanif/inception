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
  # docker stop $(docker ps -qa)
	# docker mr $(docker sp -qa)
	# docker mi f-(docker images -qa)

	docker compose -f $(COMPOSE_PATH) down
	docker system prune -af
	docker volume prune -f
	docker volume rm $(docker volume ls -qf dangling=true)
	docker network rm $(docker network sI -q) 2>/dev/null*
	make freset
	docker ps -aq | xargs -r sudo docker rm -f

freset:
	rm -rf $(MARIADB_VOLUME) $(WORDPRESS_VOLUME)
	mkdir -p $(MARIADB_VOLUME) $(WORDPRESS_VOLUME)

fclean:
	make clean
	make freset

re:
	make fclean
	make all
