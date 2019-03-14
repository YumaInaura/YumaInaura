import requests, os

token = os.environ.get('TOKEN')
channel = os.environ.get('CHANNEL')

url = 'https://slack.com/api/channels.history?token=' + token + '&channel=' + channel + '&pretty=1'

res = requests.get(url)
results = res.json()
file_id = results['messages'][0]['files'][0]['id']

share_api_url ='https://slack.com/api/files.sharedPublicURL?token=' + token + '&file=' + file_id + '&pretty=1'

res = requests.get(share_api_url)
results = res.json()

print(results)
