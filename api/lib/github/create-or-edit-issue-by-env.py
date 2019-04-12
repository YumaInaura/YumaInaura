#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# https://developer.github.com/v3/issues/#edit-an-issue
# https://gist.github.com/JeffPaine/3145490

import os, json, re, requests

OWNER = os.environ.get('OWNER')
API_KEY = os.environ.get('API_KEY')

OWNER = os.environ.get('OWNER')
REPOSITORY = os.environ.get('REPOSITORY')
ISSUE_NUMBER = os.environ.get('NUMBER')

TITLE = os.environ.get('TITLE')

if os.environ.get('FILE'):
  file = open(os.environ.get('FILE'), "r")
  body = file.read()
else:
  body = os.environ.get('BODY')
  body = re.sub(r'\\n', "\n", body)

if os.environ.get('LABELS'):
  LABELS = os.environ.get('LABELS').split(',')
else:
  LABELS = ''

def single_issue(issue_number):
  api_url = 'https://api.github.com/repos/' + OWNER + '/' + REPOSITORY + '/issues/' + issue_number
  res = requests.get(api_url)
  return(res.json())

def make_github_issue(title=None, body=None, labels=None, issue_number=None):
  session = requests.Session()
  session.auth = (OWNER, API_KEY)
 
  if issue_number:
    url = 'https://api.github.com/repos/%s/%s/issues/%s' % (OWNER, REPOSITORY, issue_number)
    issue_data = single_issue(issue_number)

    issue = {'title': title if title else issue_data['title'],
             'body': issue_data['body'] + body,
             'labels': labels if labels else issue_data['labels']}
  else:
    url = 'https://api.github.com/repos/%s/%s/issues' % (OWNER, REPOSITORY)

    issue = {'title': title,
             'body': body,
             'labels': labels if labels else []}

  r = session.post(url, json.dumps(issue))

  print(r.json())
     
make_github_issue(TITLE, body=body, labels=LABELS, issue_number=ISSUE_NUMBER)

