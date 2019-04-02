#!/usr/bin/env python3

import os, json, datetime, sys, re
from pytz import timezone
from datetime import datetime

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

  created_at = datetime.utcfromtimestamp(float(message['ts']))
  localized_date = timezone('Asia/Tokyo').localize(created_at).strftime('%Y-%m-%d %H:%M:%S %Z')

  markdown_text += localized_date + "\n\n"

print(markdown_text)
