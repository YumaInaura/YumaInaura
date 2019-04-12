#!/usr/bin/env python3

# -*- coding: utf-8 -*-

import os, sys, requests, json, fileinput, re

#resource_message = ''
#for text in sys.stdin.readlines():
#  resource_message += re.sub(r'\\n', "\n", text)

resource_message = sys.stdin.read()

from_language = os.environ.get('FROM') if os.environ.get('FROM') else 'ja'
to_language = os.environ.get('TO') if os.environ.get('TO') else 'en'
translate_format = os.environ.get('FORMAT') if os.environ.get('FORMAT') else 'text'

data = {
  'q': resource_message,
  'source': from_language,
  'target': to_language,
  'format': translate_format
}

url = 'https://translation.googleapis.com/language/translate/v2'
token = os.environ['TOKEN']

headers = {
 'Authorization': 'Bearer {}'.format(token),
 'Content-Type': 'application/json',
}

res = requests.post(url, headers=headers, json=data)

print(json.dumps(res.json()))
  
