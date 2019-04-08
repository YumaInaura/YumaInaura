#!/usr/bin/env python3

import json, config, os, re, sys, time, datetime
from datetime import timedelta

timelines = json.loads(sys.stdin.read())

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
