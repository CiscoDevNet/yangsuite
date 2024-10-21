ARG PY_VERSION=3.10

# Base image used for all stages
FROM python:${PY_VERSION} as base

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get install -yq \
      inotify-tools \
      iputils-ping \
      lsb-release \
      net-tools \
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

COPY python_dependencies/requirements.txt /tmp/requirements.txt

RUN pip install --upgrade -r /tmp/requirements.txt 


# stage for yangsuite setup
FROM python_dependencies as app_setup

EXPOSE 443 3000 8080 8086 8443 8480 9339 50051 50052 57344 57345

ARG YS_ADMIN_USER=developer
ARG YS_ADMIN_PASS=developer
ARG YS_ADMIN_EMAIL=developer@example.com

ENV DOCKER_RUN=true \
    MEDIA_ROOT=/ys-data/ \
    STATIC_ROOT=/ys-static/ \
    ALLOWED_HOSTS=localhost \
    YS_ADMIN_USER=${YS_ADMIN_USER} \
    YS_ADMIN_PASS=${YS_ADMIN_PASS} \
    YS_ADMIN_EMAIL=${YS_ADMIN_EMAIL} \
    DJANGO_SETTINGS_MODULE=yangsuite.settings.production
    
ENV DJANGO_STATIC_ROOT=${STATIC_ROOT} \
    DJANGO_ALLOWED_HOSTS=${ALLOWED_HOSTS} 

COPY build-assets/ /build-assets

RUN groupadd --gid 1000 developer \
    && useradd \
        --create-home \
        --home-dir /home/developer \
        --no-user-group \
        --no-log-init  \
        --groups developer  \
        --shell /bin/bash developer \
    && echo 'alias ll="ls -al"' >> /root/.bashrc \
    && echo 'alias ll="ls -al"' >> /home/developer/.bashrc \
    && mkdir -p ${MEDIA_ROOT} \
    && mkdir -p ${STATIC_ROOT} \
    && mkdir -p /certificate \
    && chmod u+s /bin/ping \
    && chmod +x /build-assets/start_daphne.sh \
    && chmod +x /build-assets/monitor_logs.sh \
    && chmod +x /build-assets/pick_certificate.sh \
    && chmod +x /build-assets/start_environment.sh \
    && chmod +x /build-assets/migrate_and_start.sh \
    && chmod +x /build-assets/validate_certificate.sh \
    && chmod +x /build-assets/create_self_signed_cert.sh \
    && ./build-assets/create_self_signed_cert.sh \
    && ln -snf /usr/share/zoneinfo/${CONTAINER_TIMEZONE} /etc/localtime \
    && echo ${CONTAINER_TIMEZONE} > /etc/timezone \
    && YS_DIR=$(pip show yangsuite | grep "^Location"|cut -d" " -f 2)/yangsuite \
    && yangsuite \
        --save-settings \
        --configure-only \
        --data-path ${MEDIA_ROOT} \
        --static-root ${STATIC_ROOT} \
        --allowed-hosts ${ALLOWED_HOSTS} \
        --settings yangsuite.settings.production \
    && chown -R developer:developer \
        /var/run/ \
        /var/log/ \
        /certificate \
        ${MEDIA_ROOT} \
        ${STATIC_ROOT} \
        /build-assets/ \
        ${YS_DIR}

USER developer

ENTRYPOINT ["/build-assets/start_environment.sh"]
CMD tail -f /dev/null 