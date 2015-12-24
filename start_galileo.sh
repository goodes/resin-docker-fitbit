#!/bin/bash
if [[ -z "${NO_SHELLINABOX}" ]]
then
   echo "Enabling shell in a box";
   service shellinabox start;
else
   echo "Shellinabox DISABLED";
   service shellinabox stop;
fi

SECS=${SLEEP_SECS:-60}
while true; do
     echo `date` >> /data/galileo.log;
     galileo -v sync 2>&1 >> /data/galileo_$(date +"%Y%m%d").log;
     echo "Sleeping for ${SECS} seconds";
     sleep ${SECS}
done
