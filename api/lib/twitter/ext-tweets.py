#!/usr/bin/env python3

import json, os, sys, time 
from datetime import datetime

tweets = json.loads(sys.stdin.read())

def convert_to_datetime(datetime_str):
  tweet_datetime = datetime.strptime(datetime_str,'%a %b %d %H:%M:%S %z %Y')

  return(tweet_datetime)

results = []

for tweet in tweets:
  result = tweet

  tweet_datetime = convert_to_datetime(tweet['created_at'])
  tweet_timestamp = datetime.timestamp(tweet_datetime)

  results.append()

print(json.dumps(results))
