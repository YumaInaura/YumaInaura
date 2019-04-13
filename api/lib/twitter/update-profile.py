#!/usr/bin/env python3

import json, twitterauth, base64, sys

twitter = twitterauth.twitter()

api_url = 'https://api.twitter.com/1.1/account/update_profile_image.json'

image_path = sys.argv[1]

with open(image_path, "rb") as image_file:
  image_encoded_string = base64.b64encode(image_file.read())

params = {
  "image": image_encoded_string
}

response = twitter.post(api_url, params=params)

result = response.json()

print(json.dumps(result))
