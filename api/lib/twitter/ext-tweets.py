#!/usr/bin/env python3

import json, os, sys, time, re
from datetime import datetime

tweets = json.loads(sys.stdin.read())

def convert_to_datetime(datetime_str):
  tweet_datetime = datetime.strptime(datetime_str,'%a %b %d %H:%M:%S %z %Y')

  return(tweet_datetime)

results = []

for tweet in tweets:
  result = tweet

  result['ext_entities'] = {}

  quoted_url_match = re.findall(r'(https://t.co/\w+)$',tweet['full_text'])

  if quoted_url_match:
    result['quoted_url'] = quoted_url_match[0]
  else:
    result['quoted_url'] = ''

  result['full_text_without_quoted_url'] = tweet['full_text']
  result['full_text_without_quoted_url'] = re.sub(r'https://t.co/\w+$', '', tweet['full_text_without_quoted_url'])

  tweet_datetime = convert_to_datetime(tweet['created_at'])
  result['ts'] = datetime.timestamp(tweet_datetime)

  result['ext_entities']['quoted_url'] = result['quoted_url']
  result['ext_entities']['ts'] = result['ts']
  result['ext_entities']['full_text_without_quoted_url'] = result['full_text_without_quoted_url']

  result['ext_entities']['first_resourced_url'] = tweet.get('entities', {}).get('urls', [])[0]

  if tweet.get('entities', {}).get('urls', result['ext_entities']['first_resource_url']):
    result['ext_entities']['resourced'] = True
  else:
    result['ext_entities']['resourced'] = False

  if result['ext_entities']['resourced'] and not re(r'^https://twitter.com/', :
    result['ext_entities']['outside_resourced'] = True
  else:
    result['ext_entities']['outside_resourced'] = False
    
  results.append(result)

print(json.dumps(results))

