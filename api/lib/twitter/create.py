#!/usr/bin/env python3

#https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/post-statuses-update.html

import json, config, os, re
from requests_oauthlib import OAuth1Session
import time
import datetime
from datetime import timedelta
 
CK = config.CONSUMER_KEY
CS = config.CONSUMER_SECRET
AT = config.ACCESS_TOKEN
ATS = config.ACCESS_TOKEN_SECRET
twitter = OAuth1Session(CK, CS, AT, ATS)

message = sys.stdin.read()
message = re.sub("\n", '\n' , message)

status = {
  "message" : message
}

api_url = 'https://api.twitter.com/1.1/statuses/update.json?status={message}'.format(**status)

res = twitter.post(api_url)

print(json.dumps(res.json()))

