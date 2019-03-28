
import requests, os

owner = os.environ.get('OWNER')
repository = os.environ.get('REPOSITORY')

for i in range(0, 3):
  url = 'https://api.github.com/repos/' + owner + '/' + repository + '/issues?page=' + str(i)

  res = requests.get(url)
  
  for json in res.json():
    print(json['url'])

