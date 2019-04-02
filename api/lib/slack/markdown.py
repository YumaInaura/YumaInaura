#!/usr/bin/env python3

import os, json, datetime, sys, re

stdin_lines = sys.stdin.read()

messages = json.loads(stdin_lines)

markdown_text = ''

for message in messages:
  text = message['text']
  text = re.sub('^([^。]+)。', "# \\1。\n", text, 1)

  markdown_text += text + "\n\n"

  if 'attachments' in message:
    for attachment in message['attachments']:
      markdown_text += '![image](' + attachment['image_url'] + ')' + "\n\n"

  date = datetime.datetime.utcfromtimestamp(float(message['ts'])).strftime('%Y-%m-%d %H:%M:%S')
  markdown_text += date + "\n\n"

print(markdown_text)
