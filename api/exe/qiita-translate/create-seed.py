#!/usr/bin/env python3

import sys, json, re, os, collections
from collections import defaultdict

translateds = json.loads(sys.stdin.read())

results = []

for translated in translateds:
  seed = {}

  seed['title'] = translated['en_translated_title']
  seed['body'] = translated['en_translated_body']
  seed['tags'] = translated['tags']

  results.append(seed)

print(json.dumps(results))

