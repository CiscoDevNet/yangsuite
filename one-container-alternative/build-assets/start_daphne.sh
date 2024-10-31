#!/bin/bash

# This script starts Daphne with the selected certificate and key files.

# Generate the endpoint string for SSL
ENDPOINT="ssl:8480:privateKey=$KEY_FILE:certKey=$CRT_FILE"

echo "Starting daphne..."
daphne --endpoint $ENDPOINT yangsuite.asgi:application
echo "daphne started with exit code $?"