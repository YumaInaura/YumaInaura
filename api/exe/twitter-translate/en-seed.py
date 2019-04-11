#!/usr/bin/env python3

import sys, json, re, os

tweets = json.loads(sys.stdin.read())

results = []

for tweet in tweets:
  seed = {}
  seed['text'] = tweet['translated_text'][:240] + ' '  + tweet['url']
  results.append(seed)

print(json.dumps(results))

