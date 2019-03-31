#!/usr/bin/env python3

import sys, json, pbm
#from IPython import embed

find_hashtags = sys.argv

for line in sys.stdin:
  tweet = json.loads(line)

  if not 'hashtags' in tweet['entities']:
    continue
  elif not tweet['entities']['hashtags']:
    continue
  elif not [hashtag for hashtag in tweet['entities']['hashtags'] if hashtag['text'] in find_hashtags]:
    continue
  else:
    print (json.dumps(tweet))
