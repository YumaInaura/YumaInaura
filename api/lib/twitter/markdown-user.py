#!/usr/bin/env python3

import json, os, sys, re, time, datetime

profile = json.loads(sys.stdin.read())

text = ''

profile['profile_image_url_200_200_https'] = re.sub(r'_normal\.', '_200x200.', profile['profile_image_url_https'])

text += "# {name} [@{screen_name}](https://twitter.com/{screen_name}/)\n\n".format(**profile)
text += "![image]({profile_image_url_200_200_https})\n\n".format(**profile)
text += "{description}\n\n".format(**profile)

print(text)

