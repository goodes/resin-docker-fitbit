#!/usr/bin/env python
import requests
import json
import os
import datetime
import sys


try:
    TOKEN = os.getenv("TIME_API_TOKEN", "") 
    if not TOKEN or TOKEN is "":
       raise ValueError("TIME_API_TOKEN not defined")
    URL = "http://api.timezonedb.com/v2/get-time-zone?key={}&by=zone&zone=Asia/Jerusalem&format=json".format(TOKEN)
    r = requests.get(URL)
    r.raise_for_status()
    tdata = json.loads(r.content)
    if tdata['status'] != "OK":
       raise RuntimeError("Bad response {}".format(r.content))
    tstamp = tdata['timestamp']-tdata['gmtOffset'] 
    ts = datetime.datetime.utcfromtimestamp(tdata['timestamp'])  # time.time(tstamp)
    print ts.strftime("%m%d%H%M%Y.%S")
except Exception as ex:
    sys.stderr.write("Request ERROR: {}\n".format(str(ex)))
    print ""
