#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import requests, os, json, sys

url = sys.argv[1]

print(len(sys.args > 2))

if len(sys.args > 2):
  params = json.loads(sys.argv[2])
else
  params = {}

token = os.environ.get('TOKEN')

headers = {
 'Authorization': 'Bearer {}'.format(token),
 'Content-Type': 'application/json',
}

if os.environ.get('POST'):
  res = requests.post(url, headers=headers, json=params)
else:
  res = requests.get(url, headers=headers, json=params)

print(res.json())
