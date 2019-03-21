# https://developer.twitter.com/en/docs/tweets/timelines/api-reference/get-statuses-user_timeline.html

import json, config, os, re
from requests_oauthlib import OAuth1Session
import time
import datetime
from datetime import timedelta
 
CK = config.CONSUMER_KEY
CS = config.CONSUMER_SECRET
AT = config.ACCESS_TOKEN
ATS = config.ACCESS_TOKEN_SECRET
twitter = OAuth1Session(CK, CS, AT, ATS)

url = "https://api.twitter.com/1.1/statuses/user_timeline.json"
last_id = ''

include_rts =     True if os.environ.get('INCLUDE_RTS') else False
include_replies = True if os.environ.get('INCLUDE_REPLIES') else False

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

round = int(os.environ.get('ROUND')) if os.environ.get('ROUND') else 5

for i in range(0, round-1):
  res = response(last_id)

  timelines = json.loads(res.text)
  last_id = timelines[-1]['id']

  if i >= 2:
    timelines.pop()

  for result in timelines:
    if result["in_reply_to_user_id"] and result["in_reply_to_user_id"] != 473780756:
      continue

    if result["retweeted"] and 'retweeted_status' in result and result["retweeted_status"]["user"]["id"] != 473780756:
      continue

    print(json.dumps(result))

