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

def response(max_id):
  api_params = {
    'trim_user' : True,
    'exclude_replies' : True,
    'tweet_mode' : 'extended',
    'count' : 200,
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

for i in range(0, round):
  res = response(last_id)

  timelines = json.loads(res.text)
  last_id = timelines[-1]['id']

  timelines.pop()

  for result in timelines:
    print(result['id'])

