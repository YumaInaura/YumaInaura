# WIP


# https://developer.github.com/v3/issues/#create-an-issue

# OWNER=YumaInaura REPOSITORY=playground python %:p

import requests, os

owner = os.environ.get('OWNER')
repository = os.environ.get('REPOSITORY')
token = os.environ.get('TOKEN')

url = 'https://api.github.com/repos/' + owner + '/' + repository + '/issues'

headers = {
 'Authorization': 'Bearer {}'.format(token),
 'Content-Type': 'application/json',
}

print(url)

params = {
  "title": "Found a bug",
  "body": "I'm having a problem with this."
}

res = requests.post(url, params=params)
  
print(res.json())

