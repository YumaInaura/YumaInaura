#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os, sys, requests, json, fileinput, re

token = os.environ.get('TOKEN')
translate_json_keys = os.environ.get('TRANSLATE_JSON_KEY').split(',') if os.environ.get('TRANSLATE_JSON_KEY') else ['text']

seeds = json.loads(sys.stdin.read())

results = []

for seed in seeds:
  translated = seed

  translate_format = os.environ.get('FORMAT') if os.environ.get('FORMAT') else 'text'

  if os.environ.get('FROM'):
    from_language = os.environ.get('FROM')
  elif 'from' in seed:
    from_language = seed['from']
  else:
    from_language = 'ja'

  if os.environ.get('TO'):
    to_language = os.environ.get('TO')
  elif 'from' in seed:
    to_language = seed['to']
  else:
    to_language = 'en'
 
  for translate_json_key in translate_json_keys:
    resource_message = seed[translate_json_key]
 
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

    if not res.ok:
      continue

    if os.environ.get('TRANSLATED_JSON_KEY'):
      translated_json_key = os.environ.get('TRANSLATED_JSON_KEY')
    else:
      translated_json_key = to_language + '_translated_' + translate_json_key

    translated[translated_json_key] = res.json()['data']['translations'][0]['translatedText']

  results.append(translated)
 
print(json.dumps(results))

