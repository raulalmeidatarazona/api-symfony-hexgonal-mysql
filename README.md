# Symfony 6 + PHP 8.1 + Hexagonal Architecture API Template

This is a template for creating APIs with Symfony 6, PHP 8.1, and Hexagonal Architecture.
It provides a solid foundation for building scalable, maintainable, and testable APIs, allowing you to focus on implementing your business logic.

## Features

* Symfony 6.2 framework
* PHP 8.1
* Hexagonal Architecture
* Docker setup for local development
* Basic health check endpoint
* PHPUnit for testing

## Requirements
* Docker and Docker Compose

## Getting Started
* Clone this repository and navigate to the project directory:
``git clone https://github.com/raulalmeidatarazona/api-symfony-hexgonal-mysql.git``
* RUN ``make init``
* The API should be running at http://localhost:8080.
* You can test it by visiting the health check endpoint: http://localhost:8080/health-check

## Project Structure
The project is structured using the Hexagonal Architecture pattern, which is a way of designing your application to make it more maintainable and testable.
It is based on the idea that the core of your application should not depend on the delivery mechanism (HTTP, CLI, etc.) or any other external service (database, cache, etc.).
```
├── src
│   ├── Core
│   │   ├── Application
│   │   │   ├── Command
│   │   │   └─── Query
│   │   ├── Domain
│   │   │   └─── Model
│   │   ├── EntryPoints
│   │   │   ├── Command
│   │   │   └── Http
│   │   └─── Infrastructure
│   │       └─── Domain
└── └── Shared
        ├── Domain
        └─── Infrastructure
```
## Test Suites and Coverage Configuration Explained
The phpunit.xml configuration file allows you to define separate test suites and coverage settings for your tests. Focusing on the following part of the configuration file:
```
<testsuites>
    <testsuite name="Unit">
        <directory>tests/Core/Application</directory>
        <directory>tests/Core/Domain</directory>
    </testsuite>
    <testsuite name="Integration">
        <directory>tests/Core/Infrastructure</directory>
    </testsuite>
    <testsuite name="Acceptance">
        <directory>tests/Core/Entrypoint</directory>
    </testsuite>
</testsuites>

<coverage processUncoveredFiles="true">
    <include>
        <directory suffix=".php">src/Core/Entrypoint</directory>
        <directory suffix=".php">src/Core/Application</directory>
        <directory suffix=".php">src/Core/Domain</directory>
        <directory suffix=".php">src/Core/Infrastructure</directory>
    </include>
</coverage>
```
### This configuration provides several benefits:

- Test Organization: By dividing your tests into separate test suites (Unit, Integration, and Acceptance), you can easily manage and run tests based on their type. This makes it easier to maintain and understand your test codebase.

- Targeted Test Execution: With separate test suites, you can choose to run only a specific type of tests. For example, you might want to run only unit tests during development or run acceptance tests in your CI pipeline.

- Coverage Settings: The configuration file allows you to define which directories should be included in your code coverage analysis. This helps you identify untested parts of your code and ensures that your tests cover all important areas of your application. By specifying the directories to include in the coverage report, you can focus on the most critical parts of your codebase.

In summary, configuring test suites and coverage settings in your phpunit.xml file helps keep your tests organized and maintainable. It also enables you to run targeted tests based on their type and ensures a comprehensive coverage analysis for your application.



## Customizing the Template
This template is designed to be a starting point for your API. You can customize it by adding new endpoints, services, and other components as needed. Be sure to update the documentation and tests accordingly.

## Makefile Commands
The project includes a Makefile with various helpful commands for common tasks. You can use these commands to interact with the template quickly and easily. Here's an overview of the available commands:

- `make init`: Erase any existing containers, rebuild them, start them, and install project dependencies.
- `make start`: Start the containers.
- `make stop`: Stop the containers.
- `make build`: Rebuild all the containers.
- `make restart`: Restart the containers.
- `make erase`: Erase all the containers.
- `make install`: Install the project dependencies.
- `make db`: Create the database.
- `make clean`: Clean the project (clear cache and dump autoload).
- `make sh`: Run a shell in the PHP container.
- `make unit`: Run the unit tests.
- `make integration`: Run the integration tests.
- `make acceptance`: Run the acceptance tests.
- `make tests`: Run all tests (unit, integration, and acceptance).

## Happy coding!