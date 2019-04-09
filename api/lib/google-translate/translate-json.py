#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os, sys, requests, json, fileinput, re

json_lines = sys.stdin.read()

from_language = os.environ.get('FROM') if os.environ.get('FROM') else 'ja'
to_language = os.environ.get('TO') if os.environ.get('TO') else 'en'

token = os.environ['TOKEN']
translate_json_key = os.environ['TRANSLATE_JSON_KEY'] if os.environ['TRANSLATE_JSON_KEY'] else "text"

headers = {
 'Authorization': 'Bearer {}'.format(token),
 'Content-Type': 'application/json',
}
 
api_url = 'https://translation.googleapis.com/language/translate/v2'

results = []

for line in json.loads(json_lines):
  params = {
    'q': line[translate_json_key],
    'source': from_language,
    'target': to_language,
    'format': 'text'
  }
 
  res = requests.post(api_url, headers=headers, json=params)

  trunslated_text = res.json()['data']['translations'][0]['translatedText']

  line["translated_text"] = trunslated_text

  results.append(line) 
 
print(json.dumps(results))

