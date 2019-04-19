#!/usr/bin/env python3

import sys, json, os

inputs = json.loads(sys.stdin.read())

results = []

for seed in inputs:
  result = seed
  results.append(result)

print(json.dumps(results))

