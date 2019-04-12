#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# https://developer.github.com/v3/issues/#edit-an-issue
# https://gist.github.com/JeffPaine/3145490

import os, json, re, requests

API_KEY = os.environ.get('API_KEY')

create_issues = json.loads(sys.stdin.read())

session = requests.Session()
session.auth = (OWNER, API_KEY)
 
retults = []

for create_issue in create_issues:
  owner = os.environ.get('OWNER') if os.environ.get('OWNER') else create_issue['owner']
  repository = os.environ.get('REPOSTORY') if os.environ.get('REPOSTORY') else create_issue['repository']

  api_url = 'https://api.github.com/repos/%s/%s/issues' % (owner, repository)

  title = create_issue['title']
  body = create_issue['body']
  labels = create_issue['labels'] if 'labels' in create_issue and create_issue['labels'] else []

  create = {
    'title': title,
    'body': body,
    'labels': labels
  }

  res = session.post(url, json.dumps(create))

  results.append(res.json())

print(json.dumps(results))
 
