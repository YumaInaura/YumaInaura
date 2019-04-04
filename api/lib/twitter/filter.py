#!/usr/bin/env python3

import sys, json, pbm
from optparse import OptionParser

parser = OptionParser()

parser.add_option("-e", "--end-with", dest="end_with")
(options, args) = parser.parse_args()

end_with = options.end_with
endswith = tuple(filter(None, end_with.split(',')))

tweets = json.loads(sys.stdin.read())

results = []

for tweet in tweets:
  if end_with and not tweet['full_text'].endswith(endswith):
    continue

  results.append(tweet)

print(json.dumps(results))
