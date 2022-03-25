#!/bin/bash
# Start the yanguite service in production.

# Get the system yangsuite location
PY=python3
YS_DIR=$(pip show yangsuite | grep "^Location"|cut -d" " -f 2)/yangsuite

cd $YS_DIR && \
  ${PY} manage.py collectstatic --noinput && \
  ${PY} manage.py makemigrations && \
  ${PY} manage.py migrate

if [ -z "${YS_ADMIN_USER}" ]
then
    echo "No ADMIN USER set"
fi
if [ -z "${YS_ADMIN_PASS}" ]
then
    echo "No ADMIN PASSWORD set"
fi
if [ -z "${YS_ADMIN_EMAIL}" ]
then
    echo "No ADMIN EMAIL set"
fi

echo "from django.contrib.auth.models import User; User.objects.create_superuser('${YS_ADMIN_USER}', '${YS_ADMIN_EMAIL}', '${YS_ADMIN_PASS}')" | ${PY} ${YS_DIR}/manage.py shell

echo "Starting uwsgi..."
uwsgi --ini /yangsuite/uwsgi.ini
