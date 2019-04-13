#!/usr/bin/env python3

import json, config, os, re, sys, twitterauth

twitter = twitterauth.twitter()

api_url = 'https://api.twitter.com/1.1/account/update_profile_image.json'

image = ;

params = {
  "image": image
}

response = twitter.post(api_url, params=params)

result = response.json()

print(json.dumps(result))
