#! /bin/bash

echo "################################################################"
echo "## Generating self-signed certificates...                     ##"
echo "##                                                            ##"
echo "## WARNING: Obtain certificates from a trusted authority!     ##"
echo "##                                                            ##"
echo "## NOTE: Some browsers may still reject these certificates!!  ##"
echo "################################################################"
echo " "
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/CN=localhost" -keyout nginx-self-signed.key -out nginx-self-signed.cert
