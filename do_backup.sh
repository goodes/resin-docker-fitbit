TS=$(date +"%Y-%m-%d")
FN="${RESIN_DEVICE_NAME_AT_INIT}_${TS}.tgz"
tar -cvz /data/* -C /data --exclude /data/*.tgz | curl -F "file=@-;filename=${FN}" http://active.goodes.net/station/upload/
