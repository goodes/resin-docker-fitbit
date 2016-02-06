#!/bin/bash
SECS=${BACKUP_PERIOD:-21600}
while true; do
     /data/_backups/ftp_backup >> /data/_backups/backup.log
     sleep ${SECS}
done
