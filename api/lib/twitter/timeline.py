#!/usr/bin/env python3

# https://developer.twitter.com/en/docs/tweets/timelines/api-reference/get-statuses-user_timeline.html

import json, config, os, re
from requests_oauthlib import OAuth1Session
import time
import datetime
from datetime import timedelta

if os.environ.get('TWITTER_CONSUMER_KEY'):
  CONSUMER_KEY = os.environ.get('TWITTER_CONSUMER_KEY')
  CONSUMER_SECRET = os.environ.get('TWITTER_CONSUMER_SECRET')
  ACCESS_TOKEN = os.environ.get('TWITTER_ACCESS_TOKEN')
  ACCESS_TOKEN_SECRET = os.environ.get('TWITTER_ACCESS_TOKEN_SECRET')
else:
  CONSUMER_KEY = config.CONSUMER_KEY
  CONSUMER_SECRET = config.CONSUMER_SECRET
  ACCESS_TOKEN = config.ACCESS_TOKEN
  ACCESS_TOKEN_SECRET = config.ACCESS_TOKEN_SECRET

twitter = OAuth1Session(CONSUMER_KEY, CONSUMER_SECRET, ACCESS_TOKEN, ACCESS_TOKEN_SECRET)

url = "https://api.twitter.com/1.1/statuses/user_timeline.json"
last_id = ''

include_rts =     True if (os.environ.get('INCLUDE_RTS') or os.environ.get('ALL') ) else False
include_replies = True if (os.environ.get('INCLUDE_REPLIES') or os.environ.get('ONLY_REPLIES') or os.environ.get('ALL')) else False

round = int(os.environ.get('ROUND')) if os.environ.get('ROUND') else 3
count = int(os.environ.get('COUNT')) if os.environ.get('COUNT') else 200

def response(max_id):
  api_params = {
    'trim_user' : True,
    'exclude_replies' : not(include_replies),
    'tweet_mode' : 'extended',
    'count' : count,
		'include_rts' : include_rts,
  }
  
  if max_id:
    api_params['max_id'] = max_id

  if os.environ.get('COUNT'):
    api_params['count'] = os.environ.get('COUNT')

  res = twitter.get(url, params = api_params)
  
  if res.status_code != 200:  
      print("Failed: %d" % res.status_code)
      exit()

  return res

results = []

for i in range(0, round-1):
  res = response(last_id)

  timelines = json.loads(res.text)
  last_id = timelines[-1]['id']

  if i >= 2:
    timelines.pop()

  results += timelines

results.reverse()

print(json.dumps(results))

