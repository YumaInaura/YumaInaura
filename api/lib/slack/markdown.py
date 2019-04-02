#!/usr/bin/env python3

import requests, os, json, datetime

stdin_lines = sys.stdin.read()

messages = json.loads(stdin_lines)

markdown_text = ''

for message in messages:
  
  date = datetime.datetime.utcfromtimestamp(message['ts']).strftime('%Y-%m-%d %H:%M:%S')
  markdown_text += date

print(markdown_text)
