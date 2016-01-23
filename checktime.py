#!/usr/bin/env python
import datetime
import sys
import os

now = datetime.datetime.now()

hour = float(now.hour)
mins = float(now.minute)

ts = int((hour + mins/100.0) * 100) 


if (730 < ts < 830) or (1130 < ts < 1230):
    sys.exit(0)
else:
    print "Out of range: {} vs {:02d}{:02d}".format(ts, int(hour), int(mins))
    sys.exit(1)


