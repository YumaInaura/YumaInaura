#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os, json, re, requests, sys, funcy

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

  edit_api_url = 'https://api.github.com/repos/%s/%s/issues/%s' % (owner, repository, issue_number)

  update = {}

  if 'title' in edit:
    update['title'] = edit['title']

  if 'body' in edit:
    update['body'] = edit['body']

  if 'labels' in edit:
    update['labels'] = edit['labels']

  if 'remove_labels' in edit:
    issue = get_issue(edit)
    label_names = list(funcy.pluck('name', issue['labels']))

    update['labels'] = list(set(label_names) - set(edit['remove_labels']))

  res = session.post(edit_api_url, json.dumps(update))

  results.append(res.json())
     
print(json.dumps(results))

