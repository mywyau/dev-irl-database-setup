#!/usr/bin/env bash

docker-compose -f docker-compose-auth.db.yml -p dev_auth_prod down -v
