#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os, sys, requests, json, fileinput, re

token = os.environ['TOKEN']
tranlate_json_key = os.environ['TRANSLATE_JSON_JEY'] if os.environ['TRANSLATE_JSON_JEY'] else 'text'

seeds = json.loads(sys.stdin.read())

results = []

for seed in seeds:
  trunslated = seed

  resource_message = seed[translate_json_key]
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

  translated[to_language + "_translated_text"] = res.json()['data']['translations'][0]['translatedText']

  results.append(translated)
 
print(json.dumps(results))

