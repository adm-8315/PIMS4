#!/bin/bash

# Get current date for backup file name
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backup"
BACKUP_FILE="pims_backup_${DATE}.sql"

# Create backup using mysqldump
mysqldump -h db -u "${MYSQL_USER}" -p"${MYSQL_PASSWORD}" "${MYSQL_DATABASE}" > "${BACKUP_DIR}/${BACKUP_FILE}"

# Compress backup
gzip "${BACKUP_DIR}/${BACKUP_FILE}"

# Keep only last 5 backups
cd "${BACKUP_DIR}"
ls -t *.sql.gz | tail -n +6 | xargs -r rm

echo "Backup completed: ${BACKUP_FILE}.gz"