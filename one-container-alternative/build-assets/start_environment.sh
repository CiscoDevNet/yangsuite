#!/bin/bash

# This script orchestrates the environment setup, including migration, certificate selection, validation, and starting Daphne.

echo "Starting migrate_and_start script..."
./build-assets/migrate_and_start.sh
echo "Finished migrate_and_start script..."

# Pick the right certificate
source ./build-assets/pick_certificate.sh

# Validate the selected certificate
source ./build-assets/validate_certificate.sh

# Start Daphne with HTTPS
source ./build-assets/start_daphne.sh

