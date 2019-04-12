#!/usr/bin/env python3

import sys, json, re, os, subprocess

issues = json.loads(sys.stdin.read())

results = []

for issue in issues:
  result = {}

  result['html'] = subprocess.run(['redcarpet'], stdout=subprocess.PIPE, input=issue['body'], encoding='utf-8').stdout

  result['formatted_html'] = re.sub('\n', '<br>', result['html'])

  result['en_translated_html_seed'] = subprocess.run(['../../lib/google-translate/translate-html.sh'], \
    stdout=subprocess.PIPE, input=result['formatted_html'],  encoding='utf-8').stdout.strip()

  result['en_translated_html'] = re.sub('<br>', '\n', result['en_translated_html_seed'])

  result['en_translated_title'] = subprocess.run(['../../lib/google-translate/translate-raw.sh'], \
    stdout=subprocess.PIPE, input=issue['title'],  encoding='utf-8').stdout.strip()

  result['title']  =      result['en_translated_title']
  result['body']   =      result['en_translated_html']
  result['labels'] =      ['medium','english']
  result['owner']  =      'YumaInaura'
  result['repository'] =  'YumaInaura'

  results.append(result)

print(json.dumps(results))

