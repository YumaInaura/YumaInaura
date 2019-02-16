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
  'count' : os.environ.get('COUNT') or 1000,
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

def in_jst_yesterday(tweet_datetime):
  # Only before JST 9 am it works
  today_beggining_of_day = \
    datetime.datetime.utcnow() \
    .replace(hour=15, minute=0, second=0, microsecond=0) \

  if os.environ.get('OVERTIME'):
    today_beggining_of_day -= timedelta(days=1)


  yesterday_beggining_of_day = \
    today_beggining_of_day \
    - timedelta(days=1)

  if today_beggining_of_day > tweet_datetime >= yesterday_beggining_of_day:
    return True

timelines = json.loads(res.text)

results = []

for line in timelines:
    tweet_datetime = convert_datetime(line['created_at'])

    if not in_jst_yesterday(tweet_datetime):
      continue
    if line['full_text'].find('RT') >= 0:
      continue

    text = re.sub(r'https://t\.co/\w+', '' ,line['full_text'])
    text = re.sub(r'#', '' , text)
    
    text = '# ' + text
    text += "\n" + '<a href="https://twitter.com/YumaInaura/status/' + str(line['id']) + '">' + line['created_at'] + '</a>'
    if 'media' in line['entities'].keys():
      for media in line['entities']['media']:
        text += "\n"
        text += "![image]("+media['media_url_https']+')'
    text += "\n"

    results.append(text)

results.reverse()

for result in results:
  print(result)


