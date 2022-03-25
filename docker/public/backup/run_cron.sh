#!/bin/sh
# Copyright 2020 Cisco Systems, Inc
#
# Update the crontab and start the cron daemon

BACKUP_DIR=${BACKUP_DIR:-/backup}
DATA_DIR=${DATA_DIR:-/data}
CRON_EXP=${CRON_EXP:-"*/30 * * * *"}
BACKUP_SCRIPT=/code/run_backup.sh
MAX_BACKUP=${MAX_BACKUP:-5}

[ "${NO_BACKUP}" == "true" ] && { echo "NO_BACKUP=${NO_BACKUP} set, disabling backup" ; exit 0; }

# Make sure src and dest dirs exist
[ -d "${DATA_DIR}" ] || { echo "No data dir: ${DATA_DIR}, exiting." ; exit 1; }
[ -d "${BACKUP_DIR}" ] || { echo "No backup dir: ${BACKUP_DIR}, exiting." ; exit 1; }

# setup cron
echo "${CRON_EXP} ${BACKUP_SCRIPT} ${DATA_DIR} ${BACKUP_DIR} ${MAX_BACKUP}" > /etc/crontabs/root

crond -f
