#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os, json, re, requests, sys

OWNER = os.environ.get('USER_NAME')
API_KEY = os.environ.get('API_KEY')

edits = sys.stdin.read()

session = requests.Session()
session.auth = (USER_NAME, API_KEY)
 
def get_issue(issue):
  issue_api_url = 'https://api.github.com/repos/' + issue['owner'] + '/' + issue['repository'] + '/issues/' + issue['number']
  res = requests.get(issue_api_url)
  return(res.json())

for edit in edits:
  issue_number = edit['number']
  owner = edit['owner']
  repository = edit['repository']

  issue = get_issue(issue)

  edit_api_url = 'https://api.github.com/repos/%s/%s/issues/%s' % (owner, repository, issue_number)

  update = issue

  res = session.post(edit_api_url, json.dumps(update))

  results.append(res.json())
     
print(json.dumps(results))

