#!/bin/bash

# Define variables
CERT_DIR="/build-assets/self_signed_certificates/"
PRIVATE_KEY="$CERT_DIR/private.key"
CERTIFICATE="$CERT_DIR/certificate.crt"
DAYS_VALID=1095

# Create directory for certificates if it doesn't exist
mkdir -p $CERT_DIR

# Generate a private key
openssl genpkey -algorithm RSA -out $PRIVATE_KEY -pkeyopt rsa_keygen_bits:2048

# Generate a certificate signing request (CSR) with dummy data
openssl req -new -key $PRIVATE_KEY -out "$CERT_DIR/request.csr" -subj "/C=XX/ST=SomeState/L=SomeCity/O=SomeOrganization/CN=dummy.com"

# Generate a self-signed certificate
openssl x509 -req -days $DAYS_VALID -in "$CERT_DIR/request.csr" -signkey $PRIVATE_KEY -out $CERTIFICATE

# Clean up the CSR
rm "$CERT_DIR/request.csr"

echo "Self-signed certificate created at $CERTIFICATE"