#!/usr/bin/env python3

# https://developer.twitter.com/en/docs/tweets/timelines/api-reference/get-statuses-user_timeline.html

import json, os, re, twitterauth, sys

from IPython import embed
from IPython.terminal.embed import InteractiveShellEmbed

twitter = twitterauth.twitter()

api_url = "https://api.twitter.com/1.1/statuses/user_timeline.json"

MAX_ROUND = int(os.environ.get('ROUND')) if os.environ.get('ROUND') else 30

tweet_url_or_id = sys.argv[1]

if re.search(r'\d+$', tweet_url_or_id):
  tweet_id = tweet_url_or_id
else:
  tweet_id = re.search(r'/status/(?P<id>\d+)', tweet_url_or_id)['id']

last_tweet = {}
tweets = []

for i in range(1, MAX_ROUND+1):
  status_id = last_tweet['in_reply_to_status_id_str'] if last_tweet and last_tweet['in_reply_to_status_id_str'] else tweet_id

  api_params = {
    'trim_user' : True,
    'exclude_replies' : False,
    'tweet_mode' : 'extended',
    'count' : 1,
    'max_id' : status_id,
  }
  
  response = twitter.get(api_url, params=api_params)

  if not response.json():
    break

  tweet = last_tweet = response.json()[0]

  tweets.append(tweet)

  if not tweet['in_reply_to_status_id_str']:
    break

print(json.dumps(tweets))

