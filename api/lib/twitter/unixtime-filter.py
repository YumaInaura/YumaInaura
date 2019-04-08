#!/usr/bin/env python3

import json, os, sys, time, datetime
from datetime import timedelta

start_timestamp = int(sys.argv[1])
end_timestamp = int(sys.argv[2]) if len(sys.argv) >= 3 else ''

def convert_to_datetime(datetime_str):
  tweet_time = time.strptime(datetime_str,'%a %b %d %H:%M:%S +0000 %Y')

  tweet_datetime = datetime.datetime(*tweet_time[:6])
  return(tweet_datetime)

timelines = json.loads(sys.stdin.read())

results = []

for tweet in timelines:
  tweet_datetime = convert_to_datetime(tweet['created_at'])
  tweet_timestamp = datetime.datetime.timestamp(tweet_datetime)

  if tweet_timestamp < start_timestamp:
    continue
  elif end_timestamp and tweet_timestamp > end_timestamp:
    continue
  else:
   results.append(tweet)

  print(tweet_timestamp)
#print(json.dumps(results))
