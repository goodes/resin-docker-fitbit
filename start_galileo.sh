#!/bin/bash
echo "Setting the date"
/update_date
if [[ -z "${NO_SHELLINABOX}" ]]
then
   echo "Enabling shell in a box";
   service shellinabox start;
else
   echo "Shellinabox DISABLED";
   service shellinabox stop;
fi

nohup /periodic_backup.sh > /dev/null &

SECS=${SLEEP_SECS:-60}
while true; do
     #echo `date` >> /data/galileo.log;
     /checktime.py
     if [ $? -eq 0 ]; then 
         galileo -v sync 2>&1 >> /data/galileo_$(date +"%Y%m%d").log;
     else
         echo "doing nothing for now"
     fi 
     echo "Sleeping for ${SECS} seconds";
     sleep ${SECS}
done
