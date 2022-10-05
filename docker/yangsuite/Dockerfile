# Copyright 2022 Cisco Systems, Inc

FROM ubuntu:20.04

ENV DOCKER_RUN  true

ARG PY=python3
ARG PY_VER=3.8
ARG YS_DIST=/usr/local/lib/python${PY_VER}/dist-packages/yangsuite/
ARG YS_SETTINGS=${YS_DIST}/settings/

# Postgres requires timezone to be specified at run time
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

# Install required packages and remove the apt packages cache when done
RUN apt-get update && \
    apt-get install -y \
        git \
        software-properties-common \
        postgresql \
        openssh-client \
        iputils-ping \
        python3.8 \
        python3-pip \
        gcc \
        libffi-dev \
        sqlite3 \
        vim \
        snmp \
        sendmail \
        && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Run the rest of the commands as the ``postgres`` user created by the ``postgres`` package when it was ``apt-get installed``
# USER postgres

# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
# Note: here we use ``&&\`` to run commands one after the other - the ``\``
#       allows the RUN command to span multiple lines.
# RUN   /etc/init.d/postgresql start &&\
#     psql --command "CREATE USER ysadmin WITH SUPERUSER PASSWORD 'ysadmin';" &&\
#     createdb -O ysadmin yangsuite_db

RUN mkdir -p /yangsuite/uwsgi
COPY uwsgi.ini /yangsuite/
COPY migrate_and_start.sh /yangsuite/
RUN chmod +x /yangsuite/migrate_and_start.sh
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade setuptools wheel uwsgi

# For PostgresSQL
# RUN  pip3 install --upgrade psycopg2-binary==2.8.6 tzdata

# Installing YANG Suite
RUN pip3 install --upgrade --no-cache yangsuite

# Installing YANG Suite optional free plugins
RUN pip3 install --upgrade --no-cache \
    yangsuite-grpc-telemetry \
    yangsuite-coverage \
    yangsuite-gnmi \
    yangsuite-restconf

# Uncomment to add another pypi repository to search for here
#
# ARG PIP_EXTRA_URL=https://private.pypi.com/simple
# RUN pip3 install --upgrade --no-cache --extra-index-url=${PIP_EXTRA_URL}  private_lib

# Uncomment to install optional plugin or replacement wheels
#
# COPY *.whl /yangsuite/
# RUN pip3 install --upgrade --no-cache /yangsuite/*.whl

COPY production.py ${YS_SETTINGS}
COPY wsgi.py ${YS_DIST}
RUN mkdir /ys-data
RUN mkdir /ys-static

RUN yangsuite --save-settings --configure-only \
    --allowed-hosts localhost \
    --static-root /ys-static \
    --data-path /ys-data \
    --settings yangsuite.settings.production

# For PostgresSQL
# CMD service postgresql start

CMD /etc/init.d/sendmail start
