#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# https://qiita.com/api/v2/docs#item

import os, sys, requests, json

qiita_hashtags = [{ "name": "test", "versions": [] }]

item = {
    'title': sys.argv[1],
    'body': sys.argv[2],
    "coediting": False,
    'tags': qiita_hashtags,
    'private': False,
    'tweet': False,
}

token = os.environ.get('QIITA_TOKEN')

headers = {
 'Authorization': 'Bearer {}'.format(token),
 'Content-Type': 'application/json',
}

api_url = 'https://qiita.com/api/v2/items'
response = requests.post(api_url, headers=headers, json=item)

if response.status_code == 200:
  print(json.dumps(response.json()))
else:
  print(json.dumps(response.json()))

