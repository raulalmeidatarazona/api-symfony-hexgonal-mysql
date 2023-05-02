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
``git clone https://github.com/raulalmeidatarazona/dotfiles.git``
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
## Customizing the Template
This template is designed to be a starting point for your API. You can customize it by adding new endpoints, services, and other components as needed. Be sure to update the documentation and tests accordingly.

## Happy coding!
