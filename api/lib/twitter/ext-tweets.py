#!/usr/bin/env python3

import json, os, sys, time, re
from datetime import datetime

tweets = json.loads(sys.stdin.read())

def convert_to_datetime(datetime_str):
  tweet_datetime = datetime.strptime(datetime_str,'%a %b %d %H:%M:%S %z %Y')

  return(tweet_datetime)

results = []

for tweet in tweets:
  result = tweet

  result['full_text_without_quoted_url'] = tweet['full_text']
  result['full_text_without_quoted_url'] = re.sub(r'https://t.co/\w+$', '', tweet['full_text_without_quoted_url'])

  tweet_datetime = convert_to_datetime(tweet['created_at'])
  result['ts'] = datetime.timestamp(tweet_datetime)

  results.append(result)

print(json.dumps(results))

