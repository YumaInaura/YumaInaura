#!/usr/bin/env python3

from datetime import datetime
import pytz, time, os

tz = pytz.timezone('Asia/Tokyo')

date = os.environ.get('DATE')

year = int(date.split('-')[0])
month = int(date.split('-')[1])
day = int(date.split('-')[2])

local_datetime = datetime.now(tz=tz).replace(year=year, month=month, day=day, hour=0, minute=0, second=0, microsecond=0)

unixtimestamp = time.mktime(local_datetime.timetuple())

print(unixtimestamp)
