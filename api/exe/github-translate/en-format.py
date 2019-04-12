#!/usr/bin/env python3

import sys, json, re, os, subprocess

issues = json.loads(sys.stdin.read())

results = []

for issue in issues:
  result = {}

  result['html'] = subprocess.run(['redcarpet', '--parse=fenced_code_blocks'], \
      stdout=subprocess.PIPE, input=issue['body'], encoding='utf-8').stdout

  result['formatted_html'] = re.sub('\\\\', '<br>', result['html'])
  result['formatted_html'] = re.sub('\n', '<br>', result['formatted_html'])
  result['from'] = 'ja'
  result['to'] = 'en'

  results.append(result)

print(json.dumps(results))

