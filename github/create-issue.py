# https://gist.github.com/JeffPaine/3145490

import os, json, re, requests

# Authentication for user filing issue (must have read/write access to
# repository to add issue to)
USERNAME = os.environ.get('USERNAME')
PASSWORD = os.environ.get('PASSWORD')

# The repository to add this issue to
REPO_OWNER = os.environ.get('USERNAME')
REPO_NAME = os.environ.get('REPOSITORY')

TITLE = os.environ.get('TITLE')
body = os.environ.get('BODY')

body = re.sub(r'\\n', "\n", body)

if os.environ.get('LABELS'):
  LABELS = os.environ.get('LABELS').split(',')
else:
  LABELS = ''

def make_github_issue(title, body=None, labels=None):
    '''Create an issue on github.com using the given parameters.'''
    # Our url to create issues via POST
    url = 'https://api.github.com/repos/%s/%s/issues' % (REPO_OWNER, REPO_NAME)
    # Create an authenticated session to create the issue
    session = requests.Session()
    session.auth = (USERNAME, PASSWORD)
    # Create our issue
    issue = {'title': title,
             'body': body,
             'labels': labels}
    # Add the issue to our repository
    r = session.post(url, json.dumps(issue))
    if r.status_code == 201:
        print ('Successfully created Issue {0:s}'.format(title))
    else:
        print ('Could not create Issue {0:s}'.format(title))
        print ('Response:', r.content)

    print(r.json())
     
make_github_issue(TITLE, body=body, labels=LABELS)

