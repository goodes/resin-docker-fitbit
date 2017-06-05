# Configuring the resin.io environment for each device

## Environmental Variables

Configure these under `Application` -> `Environment Variables`

| Variable | Value | Description | 
|:--- | --- | --- |
| `TIME_API_TOKEN ` | TOKEN | timezonedb.com API token to enable device to request time from timezonedb.com service. You will need this in schools where NTP Servers are blocked|
| `HTTPS_PROXY ` | PROXY_IP | Specify the IP address if a proxy server that enables HTTPS proxying if the school wifi is blocking SSL |
| `ON_HOURS ` | | `:` separated list of 24-hour formatted time ranges where it should perform synching, for example immediately before/after school and breaks. For example `0715-0840:1000-1030.:1120-1245:1430-1530`|
| `SLEEP_SECS ` | SECS | Number of seconds it will sleep between attempting a sync. The default is `300` (5 mins) if this value is not specified |
| `BACKUP_PERIOD` | SECS | If enabled, every SECS seconds, it will execute a script located at `/data/_backups/ftp_backup`. |
| `REBOOT_TIME ` | SECS | If specified and non-zero will reboot the device every SECS seconds. |


## Configuration Options
Configure these under `Application` -> `Fleet Configuration`

### Modem
#### Delta Updates
Enabling delta updates will reduce the amount of data that is transferred with every update

| Configuration Variable | Value |
|:--- | --- |
| `RESIN_SUPERVISOR_DELTA ` | `1`

#### USB Power
When using a modem, we can increase the power to the USB socket by setting the following ([Source](https://docs.resin.io/hardware/i2c-and-spi/#increase-usb-xcurrent-throughput-))

| Configuration Variable | Value |
|:--- | --- |
| `RESIN_HOST_CONFIG_max_usb_current` | `1`
| `RESIN_HOST_CONFIG_safe_mode_gpio ` | `4`
