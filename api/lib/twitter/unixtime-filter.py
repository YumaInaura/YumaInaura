#!/usr/bin/env python3

import json, os, sys, time, datetime
from datetime import timedelta

start_unixtimestamp = int(sys.argv[1])
end_unixtimestamp = int(sys.argv[2]) if 2 in sys.argv else sys.argv[2]

def convert_to_datetime(datetime_str):
  tweet_time = time.strptime(datetime_str,'%a %b %d %H:%M:%S +0000 %Y')

  tweet_datetime = datetime.datetime(*tweet_time[:6])
  return(tweet_datetime)

timelines = json.loads(sys.stdin.read())

for tweet in timelines:
  tweet_datetime = convert_to_datetime(tweet['created_at'])

  if not in_jst_yesterday(tweet_datetime):
    continue
  else:
    results.append(tweet)

print(json.dumps(results))
