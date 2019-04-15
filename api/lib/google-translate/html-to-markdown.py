#!/usr/bin/env python3

import sys, json, re, os, subprocess

issues = json.loads(sys.stdin.read())

results = []

for issue in issues:
  result = {}

  result['body']       =  re.sub(r'<br>', '\n', issue['en_translated_html'])

  result['body'] = subprocess.run(['reverse_markdown'], \
      stdout=subprocess.PIPE, input=result['body'], encoding='utf-8').stdout

  results.append(result)

print(json.dumps(results))

