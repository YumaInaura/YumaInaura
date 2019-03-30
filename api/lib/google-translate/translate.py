#!/usr/bin/env python3

# e.g
# echo "アバター\nドリル" | TOKEN=$(./get-token.sh) python ./translate.py | jq '.data.translations[].translatedText'

import os, sys, requests, json, fileinput

for line in fileinput.input():
  data = {
    'q': line,
    'source': 'ja',
    'target': 'en',
    'format': 'text'
  }
  
  url = 'https://translation.googleapis.com/language/translate/v2'
  token = os.environ['TOKEN']
  
  headers = {
   'Authorization': 'Bearer {}'.format(token),
   'Content-Type': 'application/json',
  }
  
  res = requests.post(url, headers=headers, json=data)
  
  print(json.dumps(res.json()))
  
