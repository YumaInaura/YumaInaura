#!/usr/bin/env python3

import json, config, os, re, sys, time, datetime
from datetime import timedelta
from optparse import OptionParser

timelines = json.loads(sys.stdin.read())

parser = OptionParser()

start_unixtimestamp = int(sys.argv[1])
end_unixtimestamp = int(sys.argv[2]) if 2 in sys.argv else sys.argv[2]

def convert_to_datetime(datetime_str):
  tweet_time = time.strptime(datetime_str,'%a %b %d %H:%M:%S +0000 %Y')

  tweet_datetime = datetime.datetime(*tweet_time[:6])
  return(tweet_datetime)

for tweet in timelines:
  tweet_datetime = convert_to_datetime(tweet['created_at'])

  if not in_jst_yesterday(tweet_datetime):
    continue
  else:
    results.append(tweet)

print(json.dumps(results))
