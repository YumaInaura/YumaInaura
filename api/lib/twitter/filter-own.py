#!/usr/bin/env python3

import sys, json, os

timelines = json.loads(sys.stdin.read())

OWN_USER_ID = os.environ.get('OWN_USER_ID')

results = []

for result in timelines:
  own_reply = True if result["in_reply_to_user_id_str"] == OWN_USER_ID and not result['entities']['user_mentions'] else False
  own_retweet = True if ('retweeted_status' in result and result["retweeted_status"]["user"]["id"] == OWN_USER_ID) else False

  if result["in_reply_to_user_id_str"] and not own_reply:
    continue

  if result["retweeted"] and not own_retweet:
    continue

  results.append(result)

print(json.dumps(results))
