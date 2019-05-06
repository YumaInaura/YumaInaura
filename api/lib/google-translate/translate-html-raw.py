#!/usr/bin/env python3

# -*- coding: utf-8 -*-

import os, sys, requests, json, fileinput, re, uuid

resource_message = sys.stdin.read()

from_language = os.environ.get('FROM') if os.environ.get('FROM') else 'ja'
to_language = os.environ.get('TO') if os.environ.get('TO') else 'en'
translate_format = 'html'

def codeblock_tables(resource_message):
  codeblocks_table = {}

  codeblocks = re.findall(r'<pre>(?:<code>)?(.+?)(?:</code>)?</pre>', resource_message, re.DOTALL)

  for codeblock in codeblocks:
    hex_hash = uuid.uuid4().hex
    codeblocks_table[hex_hash] = codeblock
  
  return codeblocks_table

def convert_codeblocks(resouce_message, codeblocks_table):
  for t in codeblocks_table:
    code = codeblocks_table[t]
    resource_message = re.sub(re.compile(codeblock), '<hex>' + hex_hash + '</hex>', resource_message)

  return resource_message

def revert_codeblockes(resource_message, codeblocks_table):
  for t in codeblocks_table:
    code = codeblocks_table[t]
  
    resource_message = re.sub(r'<hex>.+?</hex>', code, resource_message)

  return resource_message

def google_translate(resource_message):
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

  return(res.json()['data']['translations'][0]['translatedText'])

codeblocks_table = codeblock_tables(resource_message)
#print(resource_message); exit()
print(codeblocks_table); exit()
#resource_message = revert_codeblockes(resource_message, codeblocks_table)

# print(codeblocks_table); print(resource_message); exit()

resource_message = google_translate(resource_message)
print(resource_message)
resource_message = revert_codeblockes(resource_message, codeblocks_table)

print(resource_message)
