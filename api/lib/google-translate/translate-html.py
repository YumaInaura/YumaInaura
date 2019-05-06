#!/usr/bin/env python3

# -*- coding: utf-8 -*-

import os, sys, requests, json, fileinput, re, uuid

resource_message = sys.stdin.read()

from_language = os.environ.get('FROM') if os.environ.get('FROM') else 'ja'
to_language = os.environ.get('TO') if os.environ.get('TO') else 'en'
translate_format = 'html'

def hash_codeblockes(resource_message):
  table = {}

  codeblocks = re.findall(r'<pre>(?:<code>)?(.+?)(?:</code>)?</pre>', resource_message, re.DOTALL)

  for codeblock in codeblocks:
    hex_hash = uuid.uuid4().hex
    table[hex_hash] = codeblock
  
    resource_message = re.sub(re.compile(codeblock), '<hex>' + hex_hash + '</hex>', resource_message)

  return(table, resource_message)

table, resource_message = hash_codeblockes(resource_message)

for t in table:
  code = table[t]

  resource_message = re.sub(r'<hex>.+?</hex>', code, resource_message)

print(resource_message)


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
  
