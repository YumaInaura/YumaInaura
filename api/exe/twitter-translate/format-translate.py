#!/usr/bin/env python3

import sys, json, re, os

tweets = json.loads(sys.stdin.read())

results = []

for tweet in tweets:
  tweet['text'] = tweet['translated_text'][:250] + tweet['url']
  results.append(tweet)

print(json.dumps(results))

