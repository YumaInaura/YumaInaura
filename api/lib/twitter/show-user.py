#!/usr/bin/env python3

# https://developer.twitter.com/en/docs/accounts-and-users/follow-search-get-users/api-reference/get-users-show.html

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

params = {
  "user_id": os.environ.get('ID')
}

api_url = 'https://api.twitter.com/1.1/users/show.json'

response = twitter.get(api_url, params=params)
result = response.json()

print(json.dumps(result))
