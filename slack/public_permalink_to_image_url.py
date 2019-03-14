import requests, os, re

public_permalink = os.environ.get('URL')

res = requests.get(public_permalink)
match = re.search(r'<img src="([^\s]+?)">', res.text)

print(match[1])
