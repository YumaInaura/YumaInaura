import requests, os

url = os.environ.get('WEBHOOK_URL')

headers = {
  'Content-type': 'application/json'
}

res = requests.get(url, headers=headers)

print(res)
