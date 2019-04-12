#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os, sys, requests, json, fileinput, re

token = os.environ['TOKEN']

seeds = json.loads(sys.stdin.read())

results = []

for seed in seeds:
  trunslated = seed

  resource_message = seed['text']
  translate_format = os.environ.get('FORMAT') if os.environ.get('FORMAT') else seed['format']
  from_language = os.environ.get('FROM') if os.environ.get('FROM') else seed['from']
  to_language = os.environ.get('TO') if os.environ.get('TO') else seed['to']

  params = {
    'q': resource_message,
    'source': from_language,
    'target': to_language,
    'format': translate_format
  }
 
  api_url = 'https://translation.googleapis.com/language/translate/v2'
 
  headers = {
   'Authorization': 'Bearer {}'.format(token),
   'Content-Type': 'application/json',
  }
 
  res = requests.post(api_url, headers=headers, json=params)

  trunslated[to_language + "_trunslated"] = res.json()['data']['translations'][0]['translatedText']

  results.append(trunslated)
 
print(json.dumps(results))

