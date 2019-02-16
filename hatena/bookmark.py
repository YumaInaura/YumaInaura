import requests, sys, config, os

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

def post(bookmark_url):
  print(requests.post(bookmark_api_url + "?url=" + bookmark_url, auth=auth).content)

def delete(bookmark_url):
  print(requests.delete(bookmark_api_url + "?url=" + bookmark_url, auth=auth).content)

if __name__ == "__main__":
  stdin = str(sys.stdin.read())
  urls = stdin.split()

  for bookmark_url in urls:
    if os.environ.get('DELETE'):
      delete(bookmark_url)
    else:
      post(bookmark_url)

