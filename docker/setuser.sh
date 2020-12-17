#!/bin/bash

# Get the system yangsuite location
PY=python3
YS_PKG=yangsuite
YS_DIR=$(pip show ${YS_PKG}| grep "^Location"|cut -d" " -f 2)/${YS_PKG}

# Create a default super user with credentials passed on via the env or set
# default ones and ask the user to change them
echo "Creating default super user for admin..."
# USERNAME=${YS_ADMIN_USER:-ysadmin}
# PASSWORD=${YS_ADMIN_PASS:-ysadmin}
#EMAIL=${YS_ADMIN_EMAIL:-}
USERNAME=admin
PASSWORD=superadmin
EMAIL=ysadmin@cisco.com

[ -z "${YS_ADMIN_USER}" ] && echo "No YS_ADMIN_USER set, using username: ${USERNAME}"
[ -z "${YS_ADMIN_PASS}" ] && echo "No YS_ADMIN_PASS set, using password: ${PASSWORD} [WARNING: Please change this via the admin page]"
echo "from django.contrib.auth.models import User; User.objects.create_superuser('${USERNAME}', '${EMAIL}', '${PASSWORD}')" | ${PY} ${YS_DIR}/manage.py shell

# Start yangsuite
/usr/local/bin/yangsuite
