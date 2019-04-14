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

  seed['text'] = re.sub(quoted_url_regexp, '' , tweet['en_translated_text'])

  quoted_url_regexp = re.compile('https://t.co/\w+$')
  quoted_url_matched =  re.search(quoted_url_regexp, tweet['en_translated_text'])

  if quoted_url_matched:
    referel_url = quoted_url_matched[0]

    seed['attachment_url'] = referel_url
    seed['text'] = seed['text'][:255] + "\n" + tweet['url']
  else:
    seed['attachment_url'] = tweet['url']
    seed['text'] = seed['text'][:280]

  seed['in_reply_to_status_id'] = tweet['id_str']

  results.append(seed)

print(json.dumps(results))

