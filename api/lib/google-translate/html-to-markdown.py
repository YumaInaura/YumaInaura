#!/usr/bin/env python3

import sys, json, re, os, subprocess

issues = json.loads(sys.stdin.read())

results = []

json_keys = \
  os.environ.get('TRANSLATE_JSON_KEY').split(',') \
    if os.environ.get('TRANSLATE_JSON_KEY')  \
    else ['text']

for issue in issues:
  result = issue

  for json_key in json_keys:
    text = re.sub(r'<br>', '\n', issue[json_key])

    result[json_key] = subprocess.run(['docker', 'run', '-i', 'ruby-gems', 'reverse_markdown'], \
        stdout=subprocess.PIPE, input=result[json_key], encoding='utf-8').stdout

  results.append(result)

print(json.dumps(results))

