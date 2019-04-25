#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import requests, os, json, sys, twitterauth

url = sys.argv[1]

if len(sys.argv) > 2:
  params = json.loads(sys.argv[2])
else:
  params = {}

twitter = twitterauth.twitter()

res = twitter.post(url, params=params)

print(res.json())
