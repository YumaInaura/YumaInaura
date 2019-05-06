#!/usr/bin/env python3

# -*- coding: utf-8 -*-

import os, sys, requests, json, fileinput, re, uuid
import urllib.parse

resource_message = sys.stdin.read()

from_language = os.environ.get('FROM') if os.environ.get('FROM') else 'ja'
to_language = os.environ.get('TO') if os.environ.get('TO') else 'en'
translate_format = 'html'

def match_and_encode(match):
  return match.group(1) + urllib.parse.quote(match.group(2)) + match.group(3)

def convert_codeblocks(resource_message):
  resource_message = re.sub(r'(<pre>(?:<code>)?)(.+?)((?:</code>)?</pre>)', match_and_encode, resource_message, flags=re.DOTALL)

  return resource_message

def match_and_decode(match):
  return match.group(1) + urllib.parse.unquote(match.group(2)) + match.group(3)

def revert_codeblocks(resource_message):
  resource_message = re.sub(r'(<pre>(?:<code>)?)(.+?)((?:</code>)?</pre>)', match_and_decode, resource_message, flags=re.DOTALL)

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

resource_message = convert_codeblocks(resource_message)
resource_message = google_translate(resource_message)
resource_message = revert_codeblocks(resource_message)

print(resource_message)
exit()

