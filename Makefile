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
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} bin/console doctrine:database:create --if-not-exists

clean: ## Clean the project
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} composer dump-autoload
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} bin/console cache:clear

sh: ## Run a shell in the php container
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} sh

unit: ## Run the unit tests
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} sh -c "phpunit --order=random --testsuite=Unit"

integration: ## Run the integration tests
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} sh -c "phpunit --order=random --testsuite=Integration"

acceptance: ## Run the acceptance tests
ifndef TEST
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} sh -c "./vendor/bin/behat --stop-on-failure --no-interaction --strict"
else
		docker-compose run --rm -u ${UID}:${GID} ${DOCKER_PHP_SERVICE} sh -c "./vendor/bin/behat --stop-on-failure --no-interaction --strict $(TEST)"
endif

tests: unit integration acceptance ## Run all the tests
