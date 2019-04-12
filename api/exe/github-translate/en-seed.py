#!/usr/bin/env python3

import sys, json, re, os, subprocess

issues = json.loads(sys.stdin.read())

results = []

for issue in issues:
  result = {}

  result['title']      =  issue['en_translated_title']
  result['body']       =  issue['en_translated_html']
  result['labels']     =  ['medium', 'english', 'qiita']
  result['owner']      =  'YumaInaura'
  result['repository'] =  'YumaInaura'

  results.append(result)

print(json.dumps(results))

