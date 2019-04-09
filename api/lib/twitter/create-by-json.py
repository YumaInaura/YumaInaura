#!/usr/bin/env python3

# https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/post-statuses-update.html

import json, os, sys,twitterauth

twitter = twitterauth.twitter()

message = sys.stdin.read()

params = {
  "status" : message
}

api_url = 'https://api.twitter.com/1.1/statuses/update.json'

res = twitter.post(api_url, params=params)

print(json.dumps(res.json()))

