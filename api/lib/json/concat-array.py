#!/usr/bin/env python3

import sys, json

results = []

for input_data in sys.argv[1:]:
  data = json.loads(input_data)
  results += data

print(json.dumps(results))
