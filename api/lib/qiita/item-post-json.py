#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# https://qiita.com/api/v2/docs#item

import os, sys, requests, json

posts = json.loads(sys.stdin.read())

results = []

headers = {
 'Authorization': 'Bearer {}'.format(token),
 'Content-Type': 'application/json',
}
 
api_url = 'https://qiita.com/api/v2/items'

token = os.environ.get('QIITA_TOKEN')

for post in posts:
  item = {
      'title': post['title'],
      'body': post['body'],
      "coediting": False,
      'tags': post['tags'] if 'tags' in post else [{ "name": "test", "versions": [] }],
      'private': False,
      'tweet': False,
  }
 
  response = requests.post(api_url, headers=headers, json=item)
  
  if response.status_code == 200:
    print(json.dumps(response.json()))
    exit()
  else:
    results.append(json.dumps(response.json())

print(results)

