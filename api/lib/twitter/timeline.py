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

OWN_USER_ID = 473780756

url = "https://api.twitter.com/1.1/statuses/user_timeline.json"
last_id = ''

include_rts =     True if os.environ.get('INCLUDE_RTS') else False
include_replies = True if (os.environ.get('INCLUDE_REPLIES') or os.environ.get('ONLY_REPLIES')) else False

round = int(os.environ.get('ROUND')) if os.environ.get('ROUND') else 3

def response(max_id):
  api_params = {
    'trim_user' : True,
    'exclude_replies' : not(include_replies),
    'tweet_mode' : 'extended',
    'count' : 200,
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

for i in range(0, round-1):
  res = response(last_id)

  timelines = json.loads(res.text)
  last_id = timelines[-1]['id']

  if i >= 2:
    timelines.pop()

  for result in timelines:
    own_reply = True if result["in_reply_to_user_id"] == OWN_USER_ID else False
    own_retweet = True if ('retweeted_status' in result and result["retweeted_status"]["user"]["id"] == OWN_USER_ID) else False

    if os.environ.get("ONLY_REPLIES") and not result["in_reply_to_user_id"] and not own_reply:
      continue

    if not os.environ.get("ALL"):
  
      if result["in_reply_to_user_id"] and not own_reply:
        continue
  
      if result["retweeted"] and not own_retweet:
        continue

    print(json.dumps(result))

