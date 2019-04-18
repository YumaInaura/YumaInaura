#!/usr/bin/env python3

# https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/get-statuses-show-id
# https://twitter.com/YumaInaura/status/1112838809991798784

import json, config, os, re, twitterauth, sys

twitter = twitterauth.twitter()

last_tweet = {}
tweets = []

MAX_ROUND = int(os.environ.get('ROUND')) if os.environ.get('ROUND') else 30

tweet_url_or_id = sys.argv[1]

if re.search(r'^\d+$', tweet_url_or_id):
  tweet_id = tweet_url_or_id
else:
  tweet_id = re.search(r'/status/(?P<id>\d+)', tweet_url_or_id)['id']

for i in range(1, MAX_ROUND+1):
  api_parameter = {
    "id": last_tweet['in_reply_to_status_id_str'] if last_tweet and last_tweet['in_reply_to_status_id_str'] else tweet_id,
    "tweet_mode" : "extended"
  }
  
  api_url = "https://api.twitter.com/1.1/statuses/show.json"
 
  response = twitter.get(api_url, params=api_parameter)
  tweet = last_tweet = response.json()

  if not tweet['in_reply_to_status_id_str']:
    break
  else:
    tweets.append(tweet)

print(json.dumps(tweets))

