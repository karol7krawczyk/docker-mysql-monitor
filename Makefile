.PHONY: build up down logs clean ps shell  help restart mysql-general-logs mysql-slow-logs

export COMPOSE_PROJECT_NAME := mysql-monitor

all:
	@make -s help

up:
	@echo "Starting Docker containers..."
	docker compose up -d
	@make -s ps

build:
	@echo "Building Docker images..."
	docker compose build --no-cache

down:
	@echo "Stopping Docker containers..."
	docker compose down --remove-orphans

ps:
	@echo "List of Docker containers..."
	docker compose ps

logs:
	@echo "Fetching logs from Docker containers..."
	docker compose logs --tail=100 --follow

clean:
	@echo "Removing stopped containers and unused volumes..."
	docker compose down -v
	docker system prune -f

restart:
	@make -s down
	@make -s up

shell:
	@read -p "Enter the Docker container name: " name; \
	docker compose exec -it $$name sh

mysql-all-logs:
	@echo "Fetching general logs from Docker mysql..."
	docker compose exec -it mysql sh -c "tail -f /var/log/mysql/mysql_general.log"

mysql-slow-logs:
	@echo "Fetching slow logs from Docker mysql..."
	docker compose exec -it mysql sh -c "tail -f /var/log/mysql/mysql_slow.log"

help:
	@echo "Commands for the docker group:"
	@echo "  make up              - Start Docker containers in detached mode"
	@echo "  make build           - Build Docker images for the services defined in the Docker Compose file"
	@echo "  make down            - Stop and remove Docker containers, networks, and volumes"
	@echo "  make restart         - Restart Docker containers"
	@echo "  make clean           - Remove stopped containers and unused volumes to free up space"
	@echo "  make ps              - List the status of Docker containers"
	@echo "  make logs            - Display and follow the logs of Docker containers"
	@echo "  make shell           - Enter the shell of a specified Docker container"
	@echo "  make mysql-all-logs  - Fetching general logs from Docker mysql"
	@echo "  make mysql-slow-logs - Fetching slow logs from Docker mysql"


