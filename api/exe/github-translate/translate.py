#!/usr/bin/env python3

import sys, json, re, os, subprocess

issues = json.loads(sys.stdin.read())

results = []

for issue in issues:
  result = {}

  result['html'] = subprocess.run(['redcarpet'], stdout=subprocess.PIPE, input=issue['body'], encoding='utf-8').stdout

  result['formatted_html'] = re.sub('\n', '<br>', result['html'])

  result['translated_html_seed'] = subprocess.run(['../../lib/google-translate/translate-html.sh'], \
    stdout=subprocess.PIPE, input=result['formatted_html'],  encoding='utf-8').stdout

  result['translated_html'] = re.sub('<br>', '\n', result['translated_html_seed'])

  result['translated_title'] = subprocess.run(['../../lib/google-translate/translate.sh'], \
    stdout=subprocess.PIPE, input=issue['title'],  encoding='utf-8').stdout

  results.append(result)

print(json.dumps(results))

