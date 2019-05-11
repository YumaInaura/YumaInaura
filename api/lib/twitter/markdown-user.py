#!/usr/bin/env python

import json, os, sys, re, time, datetime

profile = json.loads(sys.stdin.read())

text = ''

profile['profile_image_url_200_200_https'] = re.sub(r'_normal\.', '_200x200.', profile['profile_image_url_https'])

text += f"# {profile['name']} [@{profile['screen_name']}](https://twitter.com/{profile['screen_name']}/)\n\n"
text += f"![image]({profile['profile_image_url_200_200_https']})\n\n"
text += f"{profile['description']}\n\n"

print(text)

