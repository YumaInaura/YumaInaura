#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import requests, json, os, sys

USER_ID = os.environ.get('QIITA_USER_NAME')
ROUND = os.environ.get('ROUND') if os.environ.get('ROUND') else 1
PER_PAGE = os.environ.get('QIITA_PER_PAGE') if os.environ.get('QIITA_PER_PAGE') else "100" 

api_url = 'https://qiita.com/api/v2/users/' + USER_ID + '/items'

results = []

# 投稿数を指定
for num in range(ROUND):
  page = str(num+1)

  params = {
    "page": page,
    "per_page" : PER_PAGE
  }

  response = requests.get(api_url, params=params)

  results.append(response.json())

print(json.dumps(results))

