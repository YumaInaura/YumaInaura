#!/usr/bin/env python3

import sys, json, re, os, subprocess
from IPython.terminal.embed import InteractiveShellEmbed

issues = json.loads(sys.stdin.read())

results = []

for issue in issues:
  result = {}

  if not issue.get('title'):
    continue

  if not issue.get('body'):
    continue

  result['title']      =  issue['title']
  result['body']       =  issue['body']

  result['labels']     =  ['medium', 'english']
  result['owner']      =  'YumaInaura'
  result['repository'] =  'YumaInaura'

  results.append(result)

print(json.dumps(results))

