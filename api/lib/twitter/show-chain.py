#!/usr/bin/env python3

# https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/get-statuses-show-id
# https://twitter.com/YumaInaura/status/1112838809991798784

import json, config, os, re
from requests_oauthlib import OAuth1Session

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

last_tweet = {}
tweets = []

MAX_ROUND = int(os.environ.get('ROUND')) if os.environ.get('ROUND') else 30

for i in range(1, MAX_ROUND+1):
  api_parameter = {
    "id": last_tweet['in_reply_to_status_id_str'] if last_tweet and last_tweet['in_reply_to_status_id_str'] else os.environ.get('ID'),
  }
  
  api_url = "https://api.twitter.com/1.1/statuses/show.json"
 
  response = twitter.get(api_url, params=api_parameter)
  tweet = last_tweet = response.json()

  if not tweet['in_reply_to_status_id_str']:
    break
  else:
    tweets.append(tweet)

print(json.dumps(tweets))
