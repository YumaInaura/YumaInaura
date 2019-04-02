#!/usr/bin/env python3

import json, config, os, re, sys, time, datetime
from datetime import timedelta

def convert_to_datetime(datetime_str):
  tweet_time = time.strptime(datetime_str,'%a %b %d %H:%M:%S +0000 %Y')

  tweet_datetime = datetime.datetime(*tweet_time[:6])
  return(tweet_datetime)

def in_jst_yesterday(tweet_datetime):
  # No ... Only before JST 9 am it works
  today_beggining_of_day = \
    datetime.datetime.utcnow() \
    .replace(hour=15, minute=0, second=0, microsecond=0) \

  if os.environ.get('BACKDAYS'):
    today_beggining_of_day -= timedelta(days=int(os.environ.get('BACKDAYS')))
  elif os.environ.get('OVERTIME'):
    today_beggining_of_day -= timedelta(days=1)

  yesterday_beggining_of_day = \
    today_beggining_of_day \
    - timedelta(days=1)

  if today_beggining_of_day > tweet_datetime >= yesterday_beggining_of_day:
    return True

results = []

timelines = json.loads(sys.stdin.read())

for tweet in timelines:
  tweet_datetime = convert_to_datetime(tweet['created_at'])

  if not in_jst_yesterday(tweet_datetime):
    continue
  else:
    results.append(tweet)

print(json.dumps(results))
