#!/usr/bin/env python3

import json, config, os, re, sys, twitterauth

twitter = twitterauth.twitter()

api_url = sys.argv[1]
params = json.loads(sys.argv[2])

if os.environ.get('POST'):
  response = twitter.post(api_url, params=params)
else:
  response = twitter.get(api_url, params=params)

result = response.json()

print(json.dumps(result))
