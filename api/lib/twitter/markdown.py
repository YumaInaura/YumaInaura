import json, os, sys, re

timelines = sys.stdin

results = []

def format_tweet(text):
    text = re.sub(r'https://t\.co/\w+', '' ,line['full_text'])
    text = re.sub(r'#', '' , text)

    text = re.sub(r'。', "。\n", text, 1)

    text = '# ' + text
    if 'extended_entities' in line and 'media' in line['extended_entities'].keys():
      for media in line['extended_entities']['media']:
        text += "\n"
        text += "![image]("+media['media_url_https']+')'
    text += "\n"

    if 'quoted_status' in line:
      text += re.sub("^|\n", "\n>", line['quoted_status']['full_text'])

    if line["entities"] and line["entities"]["urls"]:
      for url in line["entities"]["urls"]:
        text += '<{expanded_url}>'.format(**url)


    text += "\n\n" + '<a href="https://twitter.com/YumaInaura/status/' + str(line['id']) + '">' + 'Tweet'  + '</a>'

    return(text)

for line in timelines:
    line = json.loads(line)

    results.append(format_tweet(line['full_text']))

for result in results:
  print(result)

