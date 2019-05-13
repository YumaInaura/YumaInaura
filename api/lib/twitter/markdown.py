#!/usr/bin/env python3

import json, os, sys, re, time, datetime
from pytz import timezone

timelines = json.loads(sys.stdin.read())
json_text_key = os.environ.get('JSON_TEXT_KEY') if os.environ.get('JSON_TEXT_KEY') else 'full_text'
PERIOD = os.environ.get('PERIOD') if os.environ.get('PERIOD') else '。'

def convert_to_datetime(datetime_str):
  tweet_time = time.strptime(datetime_str,'%a %b %d %H:%M:%S +0000 %Y')

  tweet_datetime = datetime.datetime(*tweet_time[:6])
  return(tweet_datetime)

def format_tweet(text):
  text = re.sub(r'https://t\.co/\w+', '' , text)
  text = re.sub(r'#', '' , text)

  text = text.strip()
  text = re.sub(re.escape(PERIOD), PERIOD+"\n", text, 1)

  text = '# ' + text

  return(text)

text = ''

for tweet in timelines:
  text += format_tweet(tweet[json_text_key])
  text += "\n" + ' [*](https://twitter.com/YumaInaura/status/' + str(tweet['id_str']) + '")'

  if 'extended_entities' in tweet and 'media' in tweet['extended_entities'].keys():
    for media in tweet['extended_entities']['media']:
      text += "\n"
      text += "![image]("+media['media_url_https']+')'
  text += "\n"

  if tweet.get('quoted_status') and tweet.get('ext').get('quoted_user_screen_name'):
    text += '[@' + tweet.get('ext').get('quoted_user_screen_name') + "](" + tweet.get('ext').get('quoted_user_profile_url') + ")\n"

  if 'quoted_status' in tweet:
    text += re.sub("^|\n", "\n>", tweet['quoted_status']['full_text'])

  if not tweet.get('quoted_status') and tweet["entities"] and tweet["entities"]["urls"]:
    for url in tweet["entities"]["urls"]:
      text += '<{expanded_url}>'.format(**url)

  if tweet.get('quoted_status'):
    quote = tweet['quoted_status']
    if 'extended_entities' in quote and 'media' in quote['extended_entities'].keys():
      for media in quote['extended_entities']['media']:
        text += "\n"
        text += "![image]("+media['media_url_https']+')'
        text += "\n"

  if 'created_at' in tweet:
    tweet_datetime = convert_to_datetime(tweet['created_at'])
    utc_datetime = tweet_datetime.strftime('%Y-%m-%d %H:%M:%S UTC')
    # jst_datetime = timezone('Asia/Tokyo').localize(tweet_datetime).strftime('%Y-%m-%d %H:%M:%S %p JST')
    # text += "\n\n" + '<a href="https://twitter.com/YumaInaura/status/' + str(tweet['id_str']) + '">' + utc_datetime  + '</a>'
    #text += "\n\n" + '<a href="https://twitter.com/YumaInaura/status/' + str(tweet['id_str']) + '">Tweet</a>'

  text += "\n"

print(text)


