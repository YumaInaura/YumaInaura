#!/usr/bin/env python3

#https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/post-statuses-update.html

import json, config, os, re, sys
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

message = sys.stdin.read()

twitter = OAuth1Session(CONSUMER_KEY, CONSUMER_SECRET, ACCESS_TOKEN, ACCESS_TOKEN_SECRET)

params = {
  "status" : message
}

api_url = 'https://api.twitter.com/1.1/statuses/update.json'

res = twitter.post(api_url, params=params)

print(json.dumps(res.json()))

