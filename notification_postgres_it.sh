#!/usr/bin/env bash

docker-compose -f docker-compose-notification.it.db.yml -p dev_notification_test up -d
