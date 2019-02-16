import requests, sys, config

from requests_oauthlib import OAuth1

CK = config.CONSUMER_KEY
CS = config.CONSUMER_SECRET
AT = config.ACCESS_TOKEN
ATS = config.ACCESS_TOKEN_SECRET

auth = OAuth1(
  CK,
  CS,
  AT,
  ATS
)

bookmark_api_url = "http://api.b.hatena.ne.jp/1/my/bookmark"
bookmark_url = str(sys.stdin.read())

print(requests.post(bookmark_api_url + "?url=" + bookmark_url, auth=auth).content)

