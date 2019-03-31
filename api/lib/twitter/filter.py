#!/usr/bin/env python3

import sys, json, os

timelines = json.loads(sys.stdin.read())

OWN_USER_ID = 473780756

results = []

for result in timelines:
  own_reply = True if result["in_reply_to_user_id"] == OWN_USER_ID else False
  own_retweet = True if ('retweeted_status' in result and result["retweeted_status"]["user"]["id"] == OWN_USER_ID) else False

  if os.environ.get("ONLY_REPLIES") and not result["in_reply_to_user_id"] and not own_reply:
    continue

  if not os.environ.get("ALL"):

    if result["in_reply_to_user_id"] and not own_reply:
      continue

    if result["retweeted"] and not own_retweet:
      continue

  results.append(result)

print(json.dumps(results))
