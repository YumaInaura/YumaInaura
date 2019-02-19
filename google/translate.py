# $ cat ../twitter/log/last-timeline.log | jq --raw-output .full_text > ../log/full_text.log
# cat ../log/full_text.log | head -n 10 | python translate.py | jq .

import os, sys, requests, json, fileinput

for line in fileinput.input():
  data = {
    'q': line,
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
  
