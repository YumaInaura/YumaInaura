#!/usr/bin/env python3

import sys, json, re, os

tweets = json.loads(sys.stdin.read())

results = []

for tweet in tweets:
  use_this_tweet = False

  if tweet['is_quote_status']:
    use_this_tweet = True

  # if not tweet['in_reply_to_status_id']:
  #  use_this_tweet = True

  if not use_this_tweet:
    continue

  seed = {}

  quoted_url_regexp = re.compile('https://t.co/\w+$')
  quoted_url_matched =  re.search(quoted_url_regexp, tweet['en_translated_text'])

  if not quoted_url_matched:
    seed['attachment_url'] = tweet['url']

  seed['text'] = tweet['en_translated_text'][:280]

  seed['in_reply_to_status_id'] = tweet['id_str']

  results.append(seed)

print(json.dumps(results))

