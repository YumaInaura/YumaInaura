#!/usr/bin/env python3

import sys, json, re, os, subprocess

issues = json.loads(sys.stdin.read())

results = []

for issue in issues:
  result = issue

  result['html'] = subprocess.run(['redcarpet', '--parse=fenced_code_blocks'], \
      stdout=subprocess.PIPE, input=issue['body'], encoding='utf-8').stdout
  result['title'] = issue['title']

  result['formatted_html'] = re.sub('\n', '<br>', result['html'])
  result['from'] = 'ja'
  result['to'] = 'en'

  results.append(result)

print(json.dumps(results))

