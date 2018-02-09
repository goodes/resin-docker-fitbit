echo -n "$(date): "

TS=$(date +"%Y-%m-%d")
FN="${RESIN_DEVICE_NAME_AT_INIT}_${TS}.tgz"
TMP_BU="/data/__tmp_backup.tgz"

rm ${TMP_BU}
tar -czf ${TMP_BU} /data/* -C /data --exclude /data/*.tgz --exclude ${TMP_BU}
curl -F "file=@${TMP_BU};filename=${FN}" http://active.goodes.net/station/upload/

echo " .. DONE"
