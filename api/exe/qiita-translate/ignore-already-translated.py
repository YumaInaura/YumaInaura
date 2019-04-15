#!/usr/bin/env python3

import sys, json, re, os, collections
from collections import defaultdict

seeds = json.loads(sys.stdin.read())

results = []

for seed in seeds:
  if re(r'^[\w\s+]$',seed['title']):
    continue

  results.append(seed)

print(json.dumps(results))

