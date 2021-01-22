#!/bin/sh
# Copyright 2020 Cisco Systems, Inc

DATA_DIR=${1:-/data}
BACKUP_DIR=${2:-/backup}
MAX_BACKUP=${3:-5}

# Make sure src and dest dirs exist
[ -d "$DATA_DIR" ] || { echo "No data dir: ${DATA_DIR}, exiting." ; exit 1; }
[ -d "$BACKUP_DIR" ] || { echo "No backup dir: ${BACKUP_DIR}, exiting." ; exit 1; }

TARGET_FILE=${BACKUP_DIR}/ysbackup_$(date +%Y%m%d%H%M%S).tgz

cd $(dirname $DATA_DIR) && tar -czf ${TARGET_FILE} $(basename ${DATA_DIR}) || exit 1

[ -f ${TARGET_FILE} ] && echo "Created back up ${TARGET_FILE}"

# Remove old backups if the backup count exceeds whats expected
TOTAL_FILES=$(cd $BACKUP_DIR && ls -1 | wc -l)
RM_COUNT=$(($TOTAL_FILES - $MAX_BACKUP))

# Get the backup list in descending order of their mtimes,
# delete the last $RM_COUNT files
[ $RM_COUNT -gt 0 ] && cd $BACKUP_DIR \
    && ls -1t | tail -n $RM_COUNT | xargs rm -f
