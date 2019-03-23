# https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/post-statuses-update

import json, config, os, re, urllib.parse, unicodedata, sys
from requests_oauthlib import OAuth1Session
 
CK = config.CONSUMER_KEY
CS = config.CONSUMER_SECRET
AT = config.ACCESS_TOKEN
ATS = config.ACCESS_TOKEN_SECRET
twitter = OAuth1Session(CK, CS, AT, ATS)

message = ''

for line in sys.stdin:
  message += re.sub(r'^\s+|\s+$', '', line)

formatted_message = re.sub(r'\\n', "\n", message)

message_length = twitter_length(formatted_message)

formatted_message = formatted_message[:140]

encoded_message = urllib.parse.quote_plus(formatted_message)

tweet = {
  "status" : encoded_message,
  "in_reply_to_status_id" : os.environ.get('IN_REPLY_TO_STATUS_ID') if os.environ.get('IN_REPLY_TO_STATUS_ID') else '',
  "auto_populate_reply_metadata" : 'true',
}

url = "https://api.twitter.com//1.1/statuses/update.json?status={status}&in_reply_to_status_id={in_reply_to_status_id}&auto_populate_reply_metadata={auto_populate_reply_metadata}".format(**tweet)

if os.environ.get("DEBUG"):
  print(url)
else:
  res = twitter.post(url)
  print(json.dumps(res.json()))

