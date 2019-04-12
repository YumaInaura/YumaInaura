#!/usr/bin/env python3

import sys, json, re, os, subprocess

tweets = json.loads(sys.stdin.read())

results = []

for issue in issues:
  result = {}
  result['html_body'] = subprocess.run(['echo', issue['body'] ,' | redcarpet'])
  results.append(seed)

print(json.dumps(results))

