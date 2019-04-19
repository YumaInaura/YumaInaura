#!/usr/bin/env python3

import sys, json, re, os, subprocess
from IPython.terminal.embed import InteractiveShellEmbed

issues = json.loads(sys.stdin.read())

results = []

for issue in issues:
  result = {}

  if not issue.get('en_translated_title'):
    continue

  if not issue.get('en_translated_body'):
    continue

  result['title']      =  issue['en_translated_title']
  result['body']       =  issue['en_translated_body']

  result['labels']     =  ['medium', 'english', 'qiita']
  result['owner']      =  'YumaInaura'
  result['repository'] =  'YumaInaura'

  results.append(result)

print(json.dumps(results))

