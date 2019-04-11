#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import requests, os, json

owner = os.environ.get('OWNER')
repository = os.environ.get('REPOSITORY')
issue_number = os.environ.get('NUMBER')

api_url = 'https://api.github.com/repos/' + owner + '/' + repository + '/issues/' + issue_number

res = requests.get(api_url)
result = res.json()

print(json.dumps(result))
