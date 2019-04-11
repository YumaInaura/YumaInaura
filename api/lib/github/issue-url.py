#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import requests, os

owner = os.environ.get('OWNER')
repository = os.environ.get('REPOSITORY')
round = int(os.environ.get('ROUND')) if os.environ.get('ROUND') else 1

for i in range(0, round):
  url = 'https://api.github.com/repos/' + owner + '/' + repository + '/issues?page=' + str(i)

  res = requests.get(url)
  
  for json in res.json():
    print(json['html_url'])


