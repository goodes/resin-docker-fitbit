#!/bin/bash
SECS=${BACKUP_PERIOD:-86400}
mkdir -p /data/_backups
if (( "${BACKUP_PERIOD}" > "0" )); then
    while true; do
         echo -n "$(date): " >> /data/_backups/backup.log
         /do_backup.sh >> /data/_backups/backup.log
         echo "  sleeping ${SECS}" >> /data/_backups/backup.log
         sleep ${SECS}
    done
fi 
