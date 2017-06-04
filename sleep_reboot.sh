#!/usr/bin/env bash

# default is one day
REBOOT_TIME=${REBOOT_TIME:-86400}
echo "Starting sleep for ${REBOOT_TIME} seconds, then rebooting"
sleep "${REBOOT_TIME}"
echo "Time for reboot"
curl -X POST --header "Content-Type:application/json" "$RESIN_SUPERVISOR_ADDRESS/v1/reboot?apikey=$RESIN_SUPERVISOR_API_KEY"
