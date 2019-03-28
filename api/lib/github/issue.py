import requests, os, json

owner = os.environ.get('OWNER')
repository = os.environ.get('REPOSITORY')

results = []

for i in range(0, 3):
  api_url = 'https://api.github.com/repos/' + owner + '/' + repository + '/issues?page=' + str(i)

  res = requests.get(api_url)
  json_string = res.json()
  results.append(json_string)

print(json.dumps(results))
