#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os, sys, requests, json, fileinput, re

resource_message = sys.stdin.read()

token = os.environ['TOKEN']

results = []

for seed in json.dumps(sys.stdin.read()):
  resouce_message = seed['text']
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
 
print(json.dumps(results))
  
