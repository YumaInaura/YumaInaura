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

def results(timelines):
  line_results = []

  for line in timelines:
      # if you need tweet text then use line['full_text'] 
      line_results.append(line['created_at'] + " : " + str(line['id']))
      last_id = line['id']

  return last_id, line_results

round = int(os.environ.get('ROUND')) or 5

for i in range(0, round):
  res = response(last_id)
  timelines = json.loads(res.text)
  
  last_id, timeline_results = results(timelines)
  timeline_results.pop()

  for result in timeline_results:
    print(result)

