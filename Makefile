LOGIN = aespinos
DATADIR = /home/${LOGIN}/data
VOLWORDPRESS = ${DATADIR}/wordpress
VOLADMINER = ${DATADIR}/adminer
VOLDATABASE = ${DATADIR}/database
COMPOSE_SRCS = srcs/docker-compose.yaml
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

clean:
	@docker compose -f ${COMPOSE_SRCS} down ${DOWNFLAG}
	@sudo rm -rf ${DATADIR}

prune:
	@docker system prune -af --volumes

fclean: clean prune

re: fclean all

.PHONY: all build up start stop down clean prune fclean re
