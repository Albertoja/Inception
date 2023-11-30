LOGIN = aespinos
DATADIR = /home/${LOGIN}/data
VOLWORDPRESS = ${DATADIR}/wordpress
VOLADMINER = ${DATADIR}/adminer
VOLDATABASE = ${DATADIR}/database
COMPOSE_SRCS = srcs/docker-compose.yml
UPFLAG = --detach
DOWNFLAG = --volumes --rmi all

all: build

${VOLWORDPRESS}:
	@sudo mkdir -p ${VOLWORDPRESS}

${VOLADMINER}:
	@sudo mkdir -p ${VOLADMINER}

${VOLDATABASE}:
	@sudo mkdir -p ${VOLDATABASE}

build: | ${VOLWORDPRESS} ${VOLADMINER} ${VOLDATABASE}
	@docker compose -f ${COMPOSE_SRCS} up --build ${UPFLAG}

up: | ${VOLWORDPRESS} ${VOLADMINER} ${VOLDATABASE}
	@docker compose -f ${COMPOSE_SRCS} up ${UPFLAG}

start: | ${VOLWORDPRESS} ${VOLADMINER} ${VOLDATABASE}
	@docker compose -f ${COMPOSE_SRCS} start

stop:
	@docker compose -f ${COMPOSE_SRCS} stop

down:
	@docker compose -f ${COMPOSE_SRCS} down

clean: down
	@printf "Purge configuration ${name}...\n"
	@docker system prune -a
fclean:
	@printf "Full cleanup of all docker configurations\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker volume rm $$(docker volume ls -q)
	@docker network prune --force
	@docker volume prune --force

re: fclean all

.PHONY: all build up start stop down clean prune fclean re
