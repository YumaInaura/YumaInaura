#!/usr/bin/env python3

import json, os, sys, re

profiles = json.loads(sys.stdin.read())

for profile in profiles:
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

  if 'created_at' in tweet:
    tweet_datetime = convert_to_datetime(tweet['created_at'])
    utc_datetime = tweet_datetime.strftime('%Y-%m-%d %H:%M:%S UTC')
    # jst_datetime = timezone('Asia/Tokyo').localize(tweet_datetime).strftime('%Y-%m-%d %H:%M:%S %p JST')
    text += "\n\n" + '<a href="https://twitter.com/YumaInaura/status/' + str(tweet['id_str']) + '">' + utc_datetime  + '</a>'

  text += "\n"

print(text)


