#!/usr/bin/env python3

import sys, json, os, re 
from funcy import pluck

seeds = json.loads(sys.stdin.read())

tags_file = sys.argv[1]
read_tags_file = open(tags_file, "r").read()
tags = json.loads(read_tags_file)

dictionary_json_key = os.environ.get('DICTIONARY_JSON_KEY') if os.environ.get('DICTIONARY_JSON_KEY') else "text"
json_key = os.environ.get('ADD_HASHTAG_JSON_KEY') if os.environ.get('ADD_HASHTAG_JSON_KEY') else "text"

regexp_or = '|'.join(list(pluck(dictionary_json_key, tags)))

regex_pattern = r'(\b(?<!#)(' + regexp_or + r')\s)'
pattern = re.compile(regex_pattern, re.IGNORECASE)

results = []

for seed in seeds:
  result = seed

  result[json_key] = re.sub(pattern, "#\\1", seed[json_key])

  results.append(result)

print(json.dumps(results))

