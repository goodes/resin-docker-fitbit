#!/usr/bin/env python
import datetime
import sys
import os

hours_var = os.getenv("ON_HOURS", "0000-2400")

hour_sets = []

for rng in hours_var.split(':'):
    try:
        start, stop = rng.split('-')
        start = int(start)
        stop = int(stop)
        hour_sets.append((start, stop))
    except Exception as ex:
        print "Invalid range '{}' in var '{}'".format(
            rng, hours_var)
        sys.exit(0)

#print hour_sets

now = datetime.datetime.now()

hour = float(now.hour)
mins = float(now.minute)

ts = int((hour + mins/100.0) * 100) 

for start, stop in hour_sets:
    if (start <= ts <= stop):
        sys.exit(0)

print "Not activating, not in range: {:02d}{:02d} not in {}".format(
        int(hour), int(mins),
        ", ".join(["{:04d}-{:04d}".format(start,stop) for start,stop in hour_sets]))
sys.exit(1)


