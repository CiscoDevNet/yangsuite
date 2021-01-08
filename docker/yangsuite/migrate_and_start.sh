#!/bin/bash
# Start the yanguite service in production.

# Get the system yangsuite location
PY=python3
YS_DIR=$(pip show yangsuite | grep "^Location"|cut -d" " -f 2)/yangsuite

cd $YS_DIR && \
  ${PY} manage.py collectstatic --noinput && \
  ${PY} manage.py makemigrations && \
  ${PY} manage.py migrate

# Create a default super user with credentials passed on via the env or set
# default ones and ask the user to change them
echo "Creating default super user for admin..."
USERNAME=${YS_ADMIN_USER:-admin}
PASSWORD=${YS_ADMIN_PASS:-superuser}
EMAIL=${YS_ADMIN_EMAIL:-}

[ -z "${YS_ADMIN_USER}" ] && echo "No YS_ADMIN_USER set, using username: ${USERNAME}"
[ -z "${YS_ADMIN_PASS}" ] && echo "No YS_ADMIN_PASS set, using password: ${PASSWORD} [WARNING: Please change this via the admin page]"
echo "from django.contrib.auth.models import User; User.objects.create_superuser('${USERNAME}', '${EMAIL}', '${PASSWORD}')" | ${PY} ${YS_DIR}/manage.py shell

echo "Starting uwsgi..."
uwsgi --ini /yangsuite/uwsgi.ini
