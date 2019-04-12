#!/usr/bin/env python3

import json, os, sys, re

profiles = json.loads(sys.stdin.read())

text = ''

for profile in profiles:
  text += '# ' + profile['name']
  text += "\n\n"

  text += profile['description']
  text += "\n\n"

  text += '![image](' +  re.sub(r'_normal', '_400x400', profile['profile_image_url']) + ')'

  text += "\n"

print(text)


