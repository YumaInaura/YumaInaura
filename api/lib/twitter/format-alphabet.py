#!/usr/bin/env python3

import sys, json, re

tweets = json.loads(sys.stdin.read())

results = []

for tweet in tweets:
  full_text = tweet['full_text'].strip()

  tweet['full_text'] = re.sub(r'[a-z]+$', '', full_text)
  results.append(tweet)

print(json.dumps(results))
