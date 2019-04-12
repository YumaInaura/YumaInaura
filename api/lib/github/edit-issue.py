#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os, json, re, requests, sys

USER_NAME  = os.environ.get('USER_NAME')
API_KEY = os.environ.get('API_KEY')

edits = json.loads(sys.stdin.read())

session = requests.Session()
session.auth = (USER_NAME, API_KEY)

print(edits)

def get_issue(issue):
  issue_api_url = 'https://api.github.com/repos/' + issue['owner'] + '/' + issue['repository'] + '/issues/' + str(issue['number'])
  res = requests.get(issue_api_url)
  return(res.json())

results = []

for edit in edits:
  issue_number = str(edit['number'])
  owner = edit['owner']
  repository = edit['repository']

  issue = get_issue(edit)

  edit_api_url = 'https://api.github.com/repos/%s/%s/issues/%s' % (owner, repository, issue_number)

  print(issue['labels'])

  update = {
    "title" : issue['title'],
    "body" :  issue['body'],
    "labels" :  issue['labels']
  }

  if 'title' in edit:
    update['title'] = edit['title']

  if 'body' in edit:
    update['body'] = edit['body']

  if 'labels' in edit:
    update['labels'] = edit['labels']

  res = session.post(edit_api_url, json.dumps(update))

  results.append(res.json())
     
print(json.dumps(results))

