#!/bin/bash
echo "Setting the date"
/update_date
# if [[ -z "${NO_SHELLINABOX}" ]]
# then
#    echo "Enabling shell in a box";
#    service shellinabox start;
# else
#    echo "Shellinabox DISABLED";
#    service shellinabox stop;
# fi

nohup /periodic_backup.sh > /dev/null &

SECS=${SLEEP_SECS:-60}
REBOOT_TIME=${REBOOT_TIME:-0}

# set the date and the if set, enable the reboot script
/update_date
if (( "${REBOOT_TIME}" > "0" )); then 
   nohup /sleep_reboot.sh &
fi

while true; do
     echo "-------------------------------------------------------------------------"
     /update_date
     /checktime.py
     if [ $? -eq 0 ]; then 
         galileo --no-https-only -v sync 2>&1 >> /data/galileo_$(date +"%Y%m%d").log;
     else
         echo "doing nothing for now"
     fi 
     echo "Sleeping for ${SECS} seconds";
     sleep ${SECS}
done
