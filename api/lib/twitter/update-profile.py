#!/usr/bin/env python3

import json, twitterauth, base64, sys

twitter = twitterauth.twitter()


image_path = sys.argv[1]

with open(image_path, "rb") as image_file:
  image_encoded_string = base64.b64encode(image_file.read())

api_url = 'https://api.twitter.com/1.1/account/update_profile_image.json'

params = {
  "image": image_encoded_string
}

response = twitter.post(api_url, params=params)


print(dir(response))

#result = response.reason()

print(response)

#print(json.dumps(result))

