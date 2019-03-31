#!/usr/bin/env python3

# https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/post-statuses-destroy-id.html

import json, config, re, sys, os
from requests_oauthlib import OAuth1Session

CK = config.CONSUMER_KEY
CS = config.CONSUMER_SECRET
AT = config.ACCESS_TOKEN
ATS = config.ACCESS_TOKEN_SECRET
twitter = OAuth1Session(CK, CS, AT, ATS)

for line in sys.stdin:
  id = line.strip()
  api_url = 'https://api.twitter.com/1.1/statuses/destroy/{id}.json'.format(**{ "id" : id })

  res = twitter.post(api_url)
  print(json.dumps(res.json()))
