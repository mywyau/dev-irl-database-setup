#!/usr/bin/env bash

docker compose -f docker-compose.flyway.yml up --abort-on-container-exit
