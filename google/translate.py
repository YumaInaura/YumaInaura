# Usage
# $ TOKEN=$(./token.sh) python translate.py "Some Text"" | jq '.data.translations[0].translatedText'

import os, sys, requests, json

data = {
  'q': sys.argv[1],
  'source': 'ja',
  'target': 'en',
  'format': 'text'
}

url = 'https://translation.googleapis.com/language/translate/v2'
token = os.environ['TOKEN']

headers = {
 'Authorization': 'Bearer {}'.format(token),
 'Content-Type': 'application/json',
}

res = requests.post(url, headers=headers, json=data)

print(json.dumps(res.json()))

