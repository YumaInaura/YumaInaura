#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# https://qiita.com/api/v2/docs#item

import os, sys, requests, json

posts = json.loads(sys.stdin.read())

results = []

token = os.environ.get('QIITA_TOKEN')

headers = {
 'Authorization': 'Bearer {}'.format(token),
 'Content-Type': 'application/json',
}
 
api_url = 'https://qiita.com/api/v2/items'

for post in posts:

  if post.get('private'):
    private = True
  else:
    private = False

  if post.get('tweet'):
    tweet = True
  else:
    tweet = False

  item = {
      'title': post['title'],
      'body': post['body'],
      "coediting": False,
      'tags': post['tags'] if 'tags' in post else [{ "name": "test", "versions": [] }],
      'private': private,
      'tweet': tweet,
  }
 
  response = requests.post(api_url, headers=headers, json=item)
  
  results.append(response.json())
 
print(json.dumps(results))

