#!/usr/bin/env bash

docker compose -f docker-compose-auth-flyway.yml up --abort-on-container-exit
