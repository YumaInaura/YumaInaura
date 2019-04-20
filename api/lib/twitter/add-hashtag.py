#!/usr/bin/env python3

import sys, json, os, re 
from funcy import pluck

seeds = json.loads(sys.stdin.read())

tags_file = sys.argv[1]
read_tags_file = open(tags_file, "r").read()
tags = json.loads(read_tags_file)

json_key = os.environ.get('ADD_HASHTAG_JSON_KEY') ? os.environ.get('ADD_HASHTAG_JSON_KEY') : "text"
regexp_or = '|'.join(list(pluck(key, tags)))

regex_pattern = r'\b(?<!#)(' + regexp_or + r')\b'
pattern = re.compile(regex_pattern, re.IGNORECASE)

results = []

for seed in seeds:
  result = seed

  result['text'] = re.sub(pattern, "#\\1", seed['text'])

  results.append(result)

print(json.dumps(results))

