#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import requests, os, json

owner = os.environ.get('OWNER')
repository = os.environ.get('REPOSITORY')

results = []

round = int(os.environ.get('ROUND')) if os.environ.get('ROUND') else 3

for i in range(0, round):
  api_url = 'https://api.github.com/repos/' + owner + '/' + repository + '/issues?page=' + str(i+1)

  res = requests.get(api_url)
  json_result = res.json()
  results += json_result

print(json.dumps(results))
