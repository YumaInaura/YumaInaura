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

params ={
  'count' : os.environ.get('COUNT') or 200,
  'trim_user' : True,
  'exclude_replies' : True,
  'tweet_mode' : 'extended'
}
res = twitter.get(url, params = params)

if res.status_code != 200:  
    print("Failed: %d" % res.status_code)
    exit()

def convert_datetime(datetime_str):
  tweet_time = time.strptime(datetime_str,'%a %b %d %H:%M:%S +0000 %Y')

  tweet_datetime = datetime.datetime(*tweet_time[:6])
  return(tweet_datetime)

timelines = json.loads(res.text)

results = []

for line in timelines:
    tweet_datetime = convert_datetime(line['created_at'])

    if line['full_text'].find('RT') >= 0:
      continue

    results.append('https://twitter.com/YumaInaura/status/' + str(line['id']))

results.reverse()

for result in results:
  print(result)


