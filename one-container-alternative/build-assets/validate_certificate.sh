#!/bin/bash

# This script validates the selected certificate and key files.

# Function to check if a certificate and key are valid
check_certificate() {
    local crt_file=$1
    local key_file=$2

    # Check if the certificate and key match
    openssl x509 -noout -modulus -in "$crt_file" | openssl md5
    openssl rsa -noout -modulus -in "$key_file" | openssl md5

    if [ $? -ne 0 ]; then
        echo "Certificate and key do not match or are corrupted."
        return 1
    fi

    # Check if the certificate is expired
    openssl x509 -checkend 0 -noout -in "$crt_file"
    if [ $? -ne 0 ]; then
        echo "Certificate is expired."
        return 1
    fi

    echo "Certificate and key are valid."
    return 0
}

# Validate the certificate and key
check_certificate "$CRT_FILE" "$KEY_FILE"
if [ $? -ne 0 ]; then
    echo "Invalid certificate or key."
    exit 1
fi