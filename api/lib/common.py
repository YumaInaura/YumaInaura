import requests, os, json

url = argv[1]
params = json.loads(argv[2])

token = os.environ.get('TOKEN')

headers = {
 'Authorization': 'Bearer {}'.format(token),
 'Content-Type': 'application/json',
}

if os.environ.get('POST'):
  res = requests.post(url, headers1=headers, json=params)
else:
  res = requests.post(url, headers=headers, json=param)

print(json.dumps(res.json()))
