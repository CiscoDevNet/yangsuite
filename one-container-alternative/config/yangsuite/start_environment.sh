#!/bin/bash

# starts yangsuite, mimics behavior from yangsuite docker-compose 

source /yangsuite/setup.env

# send mail returns '550 Permission denied (real uid not trusted)' error
# it needs higher permission to start
# TODO: investigate how to start sendmail with higher permission
echo "Starting sendmail..."
/etc/init.d/sendmail start &
echo "Sendmail started with exit code $?"

echo "Starting migrate_and_start.sh..."
/yangsuite/migrate_and_start.sh &
echo "migrate_and_start.sh started with exit code $?"

echo "Starting Nginx..."
nginx -g 'daemon off;'
echo "Nginx started with exit code $?"
