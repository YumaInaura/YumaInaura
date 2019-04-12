#!/usr/bin/env python3

import sys, json, re, os, subprocess

issues = json.loads(sys.stdin.read())

results = []

for issue in issues:
  result = {}

  result['number']         = issue['number']
  result['remove_labels']  = ['en-translate']
  result['owner']          = 'YumaInaura'
  result['repository']     = 'YumaInaura'

  results.append(result)

print(json.dumps(results))

