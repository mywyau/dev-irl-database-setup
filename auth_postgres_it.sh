#!/usr/bin/env bash

docker-compose -f docker-compose-auth.it.db.yml -p dev_auth_test up -d
