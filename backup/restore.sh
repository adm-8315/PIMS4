#!/bin/bash

# Check if backup file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <backup_file>"
    exit 1
fi

BACKUP_FILE="$1"
BACKUP_DIR="/backup"

# Check if file exists
if [ ! -f "${BACKUP_DIR}/${BACKUP_FILE}" ]; then
    echo "Backup file not found: ${BACKUP_FILE}"
    exit 1
fi

# If file is gzipped, decompress it
if [[ "${BACKUP_FILE}" == *.gz ]]; then
    gunzip -c "${BACKUP_DIR}/${BACKUP_FILE}" | mysql -h db -u "${MYSQL_USER}" -p"${MYSQL_PASSWORD}" "${MYSQL_DATABASE}"
else
    mysql -h db -u "${MYSQL_USER}" -p"${MYSQL_PASSWORD}" "${MYSQL_DATABASE}" < "${BACKUP_DIR}/${BACKUP_FILE}"
fi

echo "Restore completed from: ${BACKUP_FILE}"