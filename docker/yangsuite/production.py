"""YANG Suite production deployment settings."""

import os

from yangsuite.settings.base import *     # noqa

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.getenv('DJANGO_SECRET_KEY', 'you-need-to-set-this')

DEBUG = False

if 'DJANGO_ALLOWED_HOSTS' in os.environ:
    ALLOWED_HOSTS = os.getenv('DJANGO_ALLOWED_HOSTS', 'localhost').split()
else:
    ALLOWED_HOSTS = 'localhost'

# Location to where static files will be collected
STATIC_ROOT = os.getenv('DJANGO_STATIC_ROOT', './ys-static')

# HTTPS settings
# CSRF_COOKIE_SECURE = True
# SESSION_COOKIE_SECURE = True

SESSION_ENGINE = 'django.contrib.sessions.backends.db'

DATABASE_DEFAULT = {
    'ENGINE': 'django.db.backends.sqlite3',
    'NAME': os.path.join(MEDIA_ROOT, 'db.sqlite3'),
    'OPTIONS': {
        'timeout': 180
    }
}
DATABASE_POSTGRESQL = {
    'ENGINE': 'django.db.backends.postgresql_psycopg2',
    'NAME': 'yangsuite_db',
    'USER': 'ysadmin',
    'PASSWORD': 'ysadmin',
    'HOST': 'localhost',
    'PORT': '5432',
}

DATABASES = {
    'default': DATABASE_DEFAULT
}
