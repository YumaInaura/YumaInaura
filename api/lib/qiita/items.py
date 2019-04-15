#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# https://qiita.com/api/v2/docs#item

import requests, json, os, sys

USER_ID = os.environ.get('QIITA_ITEMS_USER_NAME')
ROUND = int(os.environ.get('QIITA_ITEMS_ROUND')) if os.environ.get('QIITA_ITEMS_ROUND') else 1
PER_PAGE = os.environ.get('QIITA_ITEMS_PER_PAGE') if os.environ.get('QIITA_ITEMS_PER_PAGE') else 100

api_url = 'https://qiita.com/api/v2/users/' + USER_ID + '/items'

results = []

for num in range(ROUND):
  page = str(num+1)

  params = {
    "page": page,
    "per_page" : str(PER_PAGE)
  }

  response = requests.get(api_url, params=params)

  results += response.json()

print(json.dumps(results))

