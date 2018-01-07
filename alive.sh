SECS=${ALIVE_PERIOD:-1800}
ENDPOINT=${ALIVE_ENDPOINT:-"https://active.goodes.net/station/last_seen"}
mkdir -p /data/_alive
while true; do
    echo -n "$(date) "
    echo " $(curl -s "${ENDPOINT}/${RESIN_DEVICE_UUID}?uptime=$(cat /proc/uptime | cut -f 1 -d \ )")"
    sleep ${SECS}
done
