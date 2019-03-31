#!/usr/bin/env python3

import sys, json

for line in sys.stdin:
  tweet = json.loads(line)

  if 'entities' in tweet and 'hashtags' in tweet['entities']:# and not 'samurai' in tweet['entities']['hashtags']:
    continue
  else:
    print (json.dumps(tweet))
