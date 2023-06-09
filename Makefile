current-dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

UID=$(shell id -u)
GID=$(shell id -g)
DOCKER_PHP_SERVICE =php
DOCKER_DB_SERVICE=mysql
DOCKER_DB_PORT=3306

help: ## Show this help message
	@echo 'usage: make [target]'
	@echo
	@echo 'targets:'
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

init: erase build start install

start: ## Start the containers
		docker-compose up -d

stop: ## Stop the containers
		docker-compose stop

build: ## Rebuilds all the containers
		docker-compose build

restart: ## Restart the containers
		$(MAKE)stop && $(MAKE)start

erase: ## Erase all the containers
		docker-compose down

install: ## Install the project dependencies
		mkdir -p ~/.composer && chown ${UID}:${GID} ~/.composer
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} composer install

db: ## Create the database
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} sh -c "./bin/console d:d:d --force --if-exists"
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} sh -c "./bin/console d:d:c"
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} sh -c "./bin/console d:m:m --no-interaction"

clean: ## Clean the project
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} composer dump-autoload
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} bin/console cache:clear

sh: ## Run a shell in the php container
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} sh

unit: ## Run the unit tests
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} sh -c "phpunit --order=random --testsuite=Unit --coverage-text"

integration: ## Run the integration tests
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} sh -c "phpunit --order=random --testsuite=Integration --coverage-text"

acceptance: ## Run the acceptance tests
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} sh -c "phpunit --order=random --testsuite=Acceptance --coverage-text"

tests: unit integration acceptance ## Run all the tests
