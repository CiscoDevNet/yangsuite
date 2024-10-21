ARG PY_VERSION=3.8

# Base image used for all stages
FROM python:${PY_VERSION} as base

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get install -yq \
      iputils-ping \
      lsb-release \
      net-tools \
      nginx \
      postgresql \
      sendmail \
      snmp \
      tree \
      vim \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*


# stage for python dependencies
FROM base as python_dependencies

ARG PYTHONUNBUFFERED=1
ARG PIP_NO_CACHE_DIR=off
ARG PIP_NO_WARN_SCRIPT_LOCATION=0
ARG PIP_DISABLE_ROOT_WARNING=ignore
ARG PIP_DISABLE_PIP_VERSION_CHECK=1

COPY config/python_dependencies/requirements.txt /tmp/requirements.txt

RUN pip install --upgrade -r /tmp/requirements.txt \
    && pip install --upgrade --pre yangsuite-grpc-telemetry


# stage for nginx setup
FROM python_dependencies as nginx

COPY config/nginx/ /tmp/nginx

RUN mkdir -p /var/log/nginx \
    && mkdir -p /etc/nginx/snippets \
    && mkdir -p /etc/nginx/certs \
    && mv /tmp/nginx/nginx.conf /etc/nginx \
    && mv /tmp/nginx/uwsgi_params /etc/nginx \
    && mv /tmp/nginx/ssl-params.conf /etc/nginx/snippets \
    && mv /tmp/nginx/ssl-signed.conf /etc/nginx/snippets \
    && mv /tmp/nginx/nginx-self-signed.cert /etc/nginx/certs/ \
    && mv /tmp/nginx/nginx-self-signed.key /etc/nginx/certs/ \
    && mv /tmp/nginx/dhparam.pem /etc/nginx/certs/ \
    && rm -f /etc/nginx/conf.d/default.conf


# stage for yangsuite setup
FROM nginx as app_setup

EXPOSE 80 443 3000 8080 8086 9339 50051 50052 57345 57344

ARG PY_VERSION=3.8
ARG YS_DIST=/usr/local/lib/python${PY_VERSION}/site-packages/yangsuite/
ARG YS_SETTINGS=${YS_DIST}/settings/

ENV DOCKER_RUN=true

COPY config/yangsuite/ /yangsuite

RUN groupadd --gid 1000 developer \
    && useradd --create-home --home-dir /home/developer --no-user-group \
    --no-log-init --groups developer --shell /bin/bash developer \
    && echo 'alias ll="ls -al"' >> /root/.bashrc \
    && echo 'alias ll="ls -al"' >> /home/developer/.bashrc \
    && mkdir /ys-data \
    && mkdir /ys-static \
    && mkdir -p ${YS_DIST} \
    && mkdir -p ${YS_SETTINGS} \
    && mkdir -p /etc/nginx/html \
    && mkdir -p /var/run/uwsgi/ \
    && mkdir -p /home/developer/src \
    && mv /yangsuite/production.py ${YS_SETTINGS} \
    && chmod u+s /bin/ping \
    && chmod +x /yangsuite/migrate_and_start.sh \
    && chmod +x /yangsuite/start_environment.sh \
    && ln -snf /usr/share/zoneinfo/${CONTAINER_TIMEZONE} /etc/localtime \
    && echo ${CONTAINER_TIMEZONE} > /etc/timezone \
    && yangsuite \
        --save-settings \
        --configure-only \
        --data-path /ys-data \
        --static-root /ys-static \
        --allowed-hosts localhost \
        --settings yangsuite.settings.production \
    && cp -r /ys-static/* /etc/nginx/html/ \
    && chown -R developer:developer \
        /var/lib/nginx \
        /etc/nginx \
        /var/spool/mqueue \
        /var/run/ \
        /var/log/ \
        /ys-data/ \
        /ys-static/ \
        /yangsuite/ \
        /home/developer/ \
        ${YS_DIST}

WORKDIR /home/developer/src
USER developer 

ENTRYPOINT ["/yangsuite/start_environment.sh"]
CMD tail -f /dev/null 