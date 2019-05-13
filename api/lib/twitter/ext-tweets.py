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

  ext = {}

  quoted_url_match = re.findall(r'(https://t.co/\w+)$',tweet['full_text'])

  if quoted_url_match:
    result['quoted_url'] = quoted_url_match[0]
  else:
    result['quoted_url'] = ''

  result['full_text_without_quoted_url'] = tweet['full_text']
  result['full_text_without_quoted_url'] = re.sub(r'https://t.co/\w+$', '', tweet['full_text_without_quoted_url'])

  tweet_datetime = convert_to_datetime(tweet['created_at'])
  result['ts'] = datetime.timestamp(tweet_datetime)

  ext['quoted_url'] = result['quoted_url']
  ext['ts'] = result['ts']
  ext['full_text_without_quoted_url'] = result['full_text_without_quoted_url']

  if tweet.get('entities', {}).get('urls', []):
    ext['entities_first_expanded_url'] = tweet.get('entities').get('urls')[0]['expanded_url']
  else:
    ext['entities_first_expanded_url'] = None

  if tweet.get('entities', {}).get('urls', ext['entities_first_expanded_url']):
    ext['resourced'] = True
  else:
    ext['resourced'] = False

  if ext['resourced'] and not re.search(r'^https://twitter.com/', ext['entities_first_expanded_url']):
    ext['outside_resourced'] = True
  else:
    ext['outside_resourced'] = False

  if tweet.get('quoted_status') and ext['entities_first_expanded_url']:
    match = re.search(r'https://twitter.com/(\w+)',ext['entities_first_expanded_url'])
    ext['quoted_user_screen_name'] = match.group(1) if match else None
      
    match = re.search(r'(https://twitter.com/\w+/)',ext['entities_first_expanded_url'])
    ext['quoted_user_profile_url'] = match.group(1) if match else None
  else:
    ext['quoted_user_screen_name'] = None
    ext['quoted_user_profile_url'] = None

  result['ext'] = ext

  results.append(result)

print(json.dumps(results))

