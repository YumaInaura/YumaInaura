#!/usr/bin/env python3

import sys, json, pbm

find_hashtags = sys.argv

tweets = json.loads(sys.stdin.read())

for tweet in tweets:

  if not 'hashtags' in tweet['entities']:
    continue
  elif not tweet['entities']['hashtags']:
    continue
  elif not [hashtag for hashtag in tweet['entities']['hashtags'] if hashtag['text'] in find_hashtags]:
    continue
  else:
    print (json.dumps(tweet))
