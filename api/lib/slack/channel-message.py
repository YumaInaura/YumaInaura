# https://api.slack.com/methods/channels.history/test

import requests, os, json

if os.environ.get('WEBHOOK_URL'):
  url = os.environ.get('WEBHOOK_URL')
elif os.environ.get('TOKEN') and os.environ.get('CHANNEL'):
  url = "https://slack.com/api/channels.history?token={token}&channel={channel}&pretty=1&oldest={oldest}&latest={latest}".format(**{
    "token" : os.environ.get('TOKEN'),
    "channel" : os.environ.get('CHANNEL'),
    "oldest" : os.environ.get('OLDEST') or '',
    "latest" : os.environ.get('LATEST') or '',
    "count" : 1000
  })

headers = {
  'Content-type': 'application/json'
}

res = requests.get(url, headers=headers)

print(json.dumps(res.json()))

