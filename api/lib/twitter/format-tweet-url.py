#!/usr/bin/env python3

import sys, json, re, os

tweets = json.loads(sys.stdin.read())

results = []

for tweet in tweets:
  tweet['url'] = 'https://twitter.com/' + os.environ.get('TWITTER_USER_NAME') + '/status/' + tweet['id_str']
  results.append(tweet)

print(json.dumps(results))
