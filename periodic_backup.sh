#!/bin/bash
SECS=${BACKUP_PERIOD:-86400}
mkdir -p /data/_backups
while true; do
     /do_backup.sh >> /data/_backups/backup.log
     sleep ${SECS}
done
