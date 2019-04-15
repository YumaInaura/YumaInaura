#!/usr/bin/env python3

import sys, json, re, os, subprocess

issues = json.loads(sys.stdin.read())

results = []

json_key = os.environ.get('TRANSLATE_JSON_JEY') if os.environ.get('TRANSLATE_JSON_JEY')  else 'body'

for issue in issues:
  result = issue

  text = re.sub(r'<br>', '\n', issue[json_key])

  result[json_key] = subprocess.run(['reverse_markdown'], \
      stdout=subprocess.PIPE, input=result[json_key], encoding='utf-8').stdout

  results.append(result)

print(json.dumps(results))

