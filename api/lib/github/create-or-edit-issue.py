#!/usr/bin/env python3

# https://developer.github.com/v3/issues/#edit-an-issue
# https://gist.github.com/JeffPaine/3145490

import os, json, re, requests

USERNAME = os.environ.get('USERNAME')
PASSWORD = os.environ.get('PASSWORD')

REPO_OWNER = os.environ.get('USERNAME')
REPO_NAME = os.environ.get('REPOSITORY')
ISSUE_NUMBER = os.environ.get('ISSUE_NUMBER')

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
  api_url = 'https://api.github.com/repos/' + owner + '/' + repository + '/issues/' + issue_number
  res = requests.get(api_url)
  return(result = res.json())

def make_github_issue(title, body=None, labels=None, issue_number=None):
  session = requests.Session()
  session.auth = (USERNAME, PASSWORD)
 
    if issue_number:
      url = 'https://api.github.com/repos/%s/%s/issues/%s' % (REPO_OWNER, REPO_NAME, issue_number)
      issue_data = single_issue(issue_number)

      issue = {'title': title,
               'body': body,
               'labels': labels if labels else []}

    else:
      url = 'https://api.github.com/repos/%s/%s/issues' % (REPO_OWNER, REPO_NAME)

     issue = {'title': title,
               'body': body,
               'labels': labels if labels else []}

    r = session.post(url, json.dumps(issue))

    print(r.json())
     
make_github_issue(TITLE, body=body, labels=LABELS, issue_number=ISSUE_NUMBER)

