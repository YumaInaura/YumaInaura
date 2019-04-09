#!/usr/bin/env python3

import json, os, sys, time 
from datetime import datetime

start_timestamp = int(sys.argv[1])
end_timestamp = int(sys.argv[2]) if len(sys.argv) >= 3 else ''

def convert_to_datetime(datetime_str):
  tweet_datetime = datetime.strptime(datetime_str,'%a %b %d %H:%M:%S %z %Y')

  return(tweet_datetime)

timelines = json.loads(sys.stdin.read())

results = []

for tweet in timelines:
  tweet_datetime = convert_to_datetime(tweet['created_at'])
  tweet_timestamp = datetime.timestamp(tweet_datetime)

  if tweet_timestamp < start_timestamp:
    continue
  elif end_timestamp and tweet_timestamp > end_timestamp:
    continue
  else:
   results.append(tweet)

print(json.dumps(results))
