#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import requests, os, json, sys, twitterauth

url = sys.argv[1]

if len(sys.args > 2):
  params = json.loads(sys.argv[2])
else
  params = {}

twitter = twitterauth.twitter()

headers = {
 'Authorization': 'Bearer {}'.format(token),
 'Content-Type': 'application/json',
}

if os.environ.get('POST'):
  res = twitter.post(url, headers=headers, json=params)
else:
  res = twitter.get(url, headers=headers, json=params)

print(res.json())
