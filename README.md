# Docker Compose Setup for MySQL monitor

![License](https://img.shields.io/badge/license-MIT-blue.svg)

## Overview

This repository contains a Docker Compose setup for running MySQL and managing logs efficiently. The setup includes configuration files, environment variables, and a Makefile for common tasks. This way we can easily view and analyze all mysql queries


### Prerequisites

- Docker
- Docker Compose
- Make

## Services

### MySQL
The setting works with any mysql version

```yml
services:
  mysql:
    image: mysql:8.4
    volumes:
      - ./docker/mysql/my.cnf:/etc/mysql/conf.d/my.cnf
      - mysql_data:/var/lib/mysql
      - ./docker/mysql/init.sql:/docker-entrypoint-initdb.d/init.sql
      - ./logs:/var/log/mysql
    environment:
      MYSQL_ROOT_PASSWORD: root_password
      MYSQL_DATABASE: my_database
      MYSQL_USER: user
      MYSQL_PASSWORD: user_password
    restart: unless-stopped
    healthcheck:
      test: ["CMD-SHELL", "mysqladmin ping -h localhost -u user -puser_password"]
      interval: 30s
      timeout: 10s
      retries: 5

volumes:
  mysql_data:

```

## Cunfiguration

```bash
[mysqld]
# SQL Modes
sql_mode = "STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO"

# Connection settings
max_connections = 200

# Logging
general_log = 1
general_log_file = /var/log/mysql/mysql_general.log
slow_query_log = 1
slow_query_log_file = /var/log/mysql/mysql_slow.log
long_query_time = 1

# Character set and collation
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci

# Storage engine
default_storage_engine = InnoDB

```

## Volumes

- **mysql_data**: Persistent storage for MySQL data

## Makefile Commands

The provided Makefile includes various commands to manage the Docker Compose services and fetch MySQL logs.

### Fetching MySQL Logs

#### General Logs

To fetch general logs from the MySQL container, run:

```sh
make mysql-all-logs
```

#### Slow Logs

To fetch slow logs from the MySQL container, run:

```sh
make mysql-slow-logs
```


### Clone the repository
```bash
git clone https://github.com/Karol7Krawczyk/nginx-load-balancer.git
cd nginx-load-balancer
```

### Run in docker
```bash
make build
make up
make mysql-all-logs
make mysql-slow-logs
make help
```

## License
This project is licensed under the MIT License - see the LICENSE file for details.
