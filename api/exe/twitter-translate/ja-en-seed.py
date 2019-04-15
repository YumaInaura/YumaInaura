#!/usr/bin/env python3

import sys, json, re, os, collections
from collections import defaultdict

tweets = json.loads(sys.stdin.read())

results = []

for tweet in tweets:
  use_this_tweet = False

  if tweet['is_quote_status']:
    use_this_tweet = True

  if not tweet['in_reply_to_status_id']:
    use_this_tweet = True

  if 'extended_entities' in tweet and tweet['extended_entities']['media'][0]['type'] == 'photo':
    use_this_tweet = True

  if not use_this_tweet:
    continue

  seed = {}

  quoted_url_regexp = re.compile('https://t.co/\w+$')
  quoted_url_matched =  re.search(quoted_url_regexp, tweet['en_translated_full_text'])

  if quoted_url_matched:
    ref_url = quoted_url_matched.group(0)
    ref_url_deleted_text = re.sub(quoted_url_regexp, '', tweet['en_translated_full_text'])
    seed['text'] = ref_url_deleted_text[:255] + "\n" + ref_url
  else:
    # seed['attachment_url'] = tweet['url']
    seed['text'] = tweet['en_translated_full_text'][:280]

  seed['in_reply_to_status_id'] = tweet['id_str']

  results.append(seed)

print(json.dumps(results))

