# https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/post-statuses-update

import json, config, os, re, urllib.parse
from requests_oauthlib import OAuth1Session
 
CK = config.CONSUMER_KEY
CS = config.CONSUMER_SECRET
AT = config.ACCESS_TOKEN
ATS = config.ACCESS_TOKEN_SECRET
twitter = OAuth1Session(CK, CS, AT, ATS)

formatted_message = re.sub(r'\\n', "\n", os.environ.get("MESSAGE"))
formatted_message = formatted_message[:140]
encoded_message = urllib.parse.quote_plus(formatted_message)

url = "https://api.twitter.com//1.1/statuses/update.json?status={message}".format(**{ "message" : encoded_message })

if os.environ.get("DEBUG"):
  print(encoded_message)
else:
  res = twitter.post(url)
  print(res.json())

