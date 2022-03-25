#! /bin/bash

echo "Hello, please setup YANG Suite admin user."

echo -n "username: "
read -r
ADMIN_USER=$REPLY

echo -n "password: "
read -s
PASS_ONE=$REPLY

echo ""

echo -n "confirm password: "
read -s
PASS_TWO=$REPLY

echo ""

die() {
    echo "Exiting...."
    exit 1
}

if [ "${PASS_ONE}" != "${PASS_TWO}" ]
then
    echo "Password does not match"
    die
fi

echo -n "email: "
read -r
ADMIN_EMAIL=$REPLY

echo ""

if [ -z "${ADMIN_EMAIL}" ]
then
    echo "Email required"
    die
fi

if [ -f nginx/nginx-self-signed.cert ] && [ -f nginx/nginx-self-signed.key ]
then
    echo " "
    echo "Certificates already generated"
    echo " "
else
    echo -n "Setup test certificates? (y/n): "
    read -r
    YS_CERTS=$REPLY
    if [ "${YS_CERTS}" == "y" ]
    then
        echo "################################################################"
        echo "## Generating self-signed certificates...                     ##"
        echo "##                                                            ##"
        echo "## WARNING: Obtain certificates from a trusted authority!     ##"
        echo "##                                                            ##"
        echo "## NOTE: Some browsers may still reject these certificates!!  ##"
        echo "################################################################"
        echo " "
        openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx/nginx-self-signed.key -out nginx/nginx-self-signed.cert
        if [ -f nginx/nginx-self-signed.cert ] && [ -f nginx/nginx-self-signed.key ]
        then
            echo "Certificates generated..."
        else
            echo "Certificates not generated..."
            die
        fi
    else
        echo "Are key and certificate files in nginx/ directory with file names added to nginx/dockerfile and nginx/ssl-signed.conf? (y/n): "
        read -r
        CONTINUE=$REPLY

        if [ "${CONTINUE}" != "y" ]
        then
            die
        fi
    fi
fi

echo "Building docker containers..."

cat >"yangsuite/setup.env" <<%%
DJANGO_SETTINGS_MODULE=yangsuite.settings.production
MEDIA_ROOT=/ys-data/
STATIC_ROOT=/ys-static/
DJANGO_STATIC_ROOT=/ys-static/
DJANGO_ALLOWED_HOSTS=localhost
YS_ADMIN_USER=$ADMIN_USER
YS_ADMIN_PASS=$PASS_ONE
YS_ADMIN_EMAIL=$ADMIN_EMAIL
%%

docker-compose up --build
