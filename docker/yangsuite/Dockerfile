# Copyright 2020 Cisco Systems, Inc

FROM ubuntu:18.04

ENV DOCKER_RUN  true

ARG PY=python3.6
ARG PY_VER=3.6
ARG YS_DIST=/usr/local/lib/python${PY_VER}/dist-packages/yangsuite/
ARG YS_SETTINGS=${YS_DIST}/settings/

# Install required packages and remove the apt packages cache when done
RUN apt-get update && \
    apt-get install -y \
        git \
        openssh-client \
        iputils-ping \
        python3.6 \
        python3-pip \
        sqlite3 \
        vim \
        snmp \
        && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN mkdir -p /yangsuite/uwsgi
COPY uwsgi.ini /yangsuite/
COPY migrate_and_start.sh /yangsuite/
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade setuptools wheel uwsgi

# Installing YANG Suite
RUN pip3 install --upgrade --no-cache yangsuite[core]

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
