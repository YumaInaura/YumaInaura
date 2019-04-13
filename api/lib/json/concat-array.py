#!/usr/bin/env python3

import sys, json

results = []

for input_data in sys.argv[1:]:
  results += json.loads(input_data)

print(json.dumps(results))
