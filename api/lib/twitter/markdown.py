#!/usr/bin/env python3

import json, os, sys, re, time, datetime
from pytz import timezone

timelines = json.loads(sys.stdin.read())

def convert_to_datetime(datetime_str):
  tweet_time = time.strptime(datetime_str,'%a %b %d %H:%M:%S +0000 %Y')

  tweet_datetime = datetime.datetime(*tweet_time[:6])
  return(tweet_datetime)

def format_tweet(t):
  t = re.sub(r'https://t\.co/\w+', '' , t)
  t = re.sub(r'#', '' , t)

  t = re.sub(r'。', "。\n", t, 1)

  t = '# ' + t

  return(t)

text = ''

for tweet in timelines:
  tweet_datetime = convert_to_datetime(tweet['created_at'])
  utc_datetime = tweet_datetime.strftime('%Y-%m-%d %H:%M:%S UTC')
  # jst_datetime = timezone('Asia/Tokyo').localize(tweet_datetime).strftime('%Y-%m-%d %H:%M:%S %p JST')

  text += format_tweet(tweet['full_text'])

  if 'extended_entities' in tweet and 'media' in tweet['extended_entities'].keys():
    for media in tweet['extended_entities']['media']:
      text += "\n"
      text += "![image]("+media['media_url_https']+')'
  text += "\n"

  if 'quoted_status' in tweet:
    text += re.sub("^|\n", "\n>", tweet['quoted_status']['full_text'])

  if tweet["entities"] and tweet["entities"]["urls"]:
    for url in tweet["entities"]["urls"]:
      text += '<{expanded_url}>'.format(**url)

  text += "\n\n" + '<a href="https://twitter.com/YumaInaura/status/' + str(tweet['id']) + '">' + utc_datetime  + '</a>'
  text += "\n"

print(text)


