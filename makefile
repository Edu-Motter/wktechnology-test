SHELL := /bin/bash

GREEN  := \033[0;32m
NC     := \033[0m  # No Color

.PHONY: build run

build:
	cd backend && \
	./mvnw clean install -DskipTests

run: build
	cd backend && \
	docker compose up -d --no-deps --build spring-app && \
	echo -e "$(GREEN) ✔ Running MySQL Database:$(NC)docker wk-database on port 3307 $(NC)" && \
	echo -e "$(GREEN) ✔ Running Spring Boot Application:$(NC)docker wk-backend on port 8082 "
