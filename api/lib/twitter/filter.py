#!/usr/bin/env python3

import sys, json, re
from optparse import OptionParser

parser = OptionParser()

parser.add_option("-e", "--end-with", dest="end_with")
parser.add_option("-m", "--match", dest="match")
(options, args) = parser.parse_args()

end_with = options.end_with
endswith = tuple(filter(None, end_with.split(',')))

match_on = re.compile(options.match)

tweets = json.loads(sys.stdin.read())

results = []

for tweet in tweets:
  hit = False

  full_text = tweet['full_text'].strip()

  formatted_full_text = tweet['full_text']
  formatted_full_text = re.sub(r'http[^_s]+', '', formatted_full_text)

  print(formatted_full_text)

  if end_with and formatted_full_text.endswith(endswith):
    hit = True

  if match_on and re.match(match_on, tweet['full_text']):
    hit = True

  if hit:
    results.append(tweet)

print(json.dumps(results))
