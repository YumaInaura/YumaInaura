#!/usr/bin/env python3

# https://developer.twitter.com/en/docs/accounts-and-users/manage-account-settings/api-reference/post-account-update_profile_image.html

# The avatar image for the profile, base64-encoded. Must be a valid GIF, JPG, or PNG image of less than 700 kilobytes in size. Images with width larger than 400 pixels will be scaled down. Animated GIFs will be converted to a static GIF of the first frame, removing the animation.

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

print(json.dumps(response.json()))

