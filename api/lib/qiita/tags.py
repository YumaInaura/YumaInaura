#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# https://qiita.com/api/v2/docs#tag

import requests, json, os, sys

page_round = int(os.environ.get('QIITA_TAGS_ROUND')) if os.environ.get('QIITA_TAGS_ROUND') else 1
per_page = os.environ.get('QIITA_TAGS_PER_PAGE') if os.environ.get('QIITA_TAGS_PER_PAGE') else 100

api_url = 'https://qiita.com/api/v2/tags'

results = []

for i in range(page_round):
  page = str(i+1)

  params = {
    "page": page,
    "per_page" : 100,
    "sort" : "count"
  }

  response = requests.get(api_url, params=params)

  if not response.ok:
    break

  results += response.json()

print(json.dumps(results))

