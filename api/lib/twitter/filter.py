#!/usr/bin/env python3

import sys, json, pbm
from optparse import OptionParser

parser = OptionParser()

parser.add_option("-e", "--end-with", dest="end_with")
(options, args) = parser.parse_args()

print(options.end_with)
exit()

find_hashtags = sys.argv

tweets = json.loads(sys.stdin.read())

results = []

for tweet in tweets:
  results.append(tweet)

print(json.dumps(results))
