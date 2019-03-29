#!/usr/bin/env python3

import time, re, requests, json, sys
from datetime import datetime
from datetime import timedelta

# --------------------------------------------------------
# Basic
# --------------------------------------------------------

#stdin_line = sys.stdin.readline()

stdin_line = ''
for text in sys.stdin.readlines():
  stdin_line += re.sub(r'\\n', "\n", text)

input_data = { 'text': stdin_line }
out = {}

out['raw_text'] = input_data['text']
out['text_length'] = len(input_data['text'])

# --------------------------------------------------------
# Time
# --------------------------------------------------------

now = datetime.now()
out['jst_date'] = (datetime.now() + timedelta(hours=9)).strftime('%Y-%m-%d')
out['unixtime'] = int(time.mktime(now.timetuple()))

# --------------------------------------------------------
# Image URL in TEXT
# --------------------------------------------------------

def image_url_match(text):
    image_url_match_regexp = re.compile(r'(https://[^\s]+\.(png|jpg|gif)(\?[^\s]+)?)')
    image_url_match = re.search(image_url_match_regexp, text)
    return image_url_match

image_url_matched = image_url_match(input_data['text'])

if image_url_matched:
    out['public_image_url'] = image_url_matched[0]
    out['public_image_markdown'] = '![image](' + out['public_image_url'] + ')'
    out['image'] = True
else:
    out['public_image_url'] = out['public_image_markdown'] = ''
    out['image'] = False

# --------------------------------------------------------
# Text
# --------------------------------------------------------


def delete_custom_tag(text):
    return re.sub(r'tags:([a-zA-Z0-9,]+)', '', text)

def delete_hashtag(text):
    return re.sub(r'(^|\s)#([^\s+]) ', '\\1\\2', text)

def delete_image_url(text):
    return re.sub(r'https?://[^\s]+/[^\s]+\.(png|jpg|gif)(\?[^\s]+)?', '', text)

out['newlined_text'] = re.sub(r'。', "\n。", input_data['text'] , 1)

out['first_line_text'] = out['newlined_text'].split("\n")[0]

match_tags = re.search(r'tags:([a-zA-Z0-9,]+)', input_data['text'])
custom_tags_deleted_text = out['custom_tags_deleted_text'] = delete_custom_tag(input_data['text'])
formatted_text = out['formatted_text'] = re.sub(r'[#\s]', '', custom_tags_deleted_text)
formatted_text = out['formatted_text'] = delete_image_url(formatted_text)

out['text_for_translate'] = out['formatted_text'][:900] + (out['formatted_text'][900:] and '..')

text_split_mark = "。"


out['newline_text'] = formatted_text.replace(r'。', "。\n\n")

out['text_length'] = len(custom_tags_deleted_text)

# --------------------------------------------------------
# Twitter
# --------------------------------------------------------

out['_extra_deleted_text'] = delete_image_url(custom_tags_deleted_text)

if len(input_data['text']) >= 280:
    out['twitter_mode'] = 'none'
    out['twitter_text'] = out['_extra_deleted_text'][:110] + (out['_extra_deleted_text'][110:] and '..')
elif len(out['_extra_deleted_text']) > 140:
    out['twitter_mode'] = 'link'
    out['twitter_link_mode'] = True
    out['twitter_text'] = out['_extra_deleted_text'][:110] + (out['_extra_deleted_text'][110:] and '..')
elif out['image']:
    out['twitter_mode'] = 'image'
    out['twitter_image_mode'] = True
    out['twitter_text'] = out['_extra_deleted_text'][:140] + (out['_extra_deleted_text'][140:] and '..')
else:
    out['twitter_mode'] = 'single'
    out['twitter_single_mode'] = True
    out['twitter_text'] = out['_extra_deleted_text'][:140] + (out['_extra_deleted_text'][140:] and '..')

twitter_links = re.search(r'https://twitter.com/\w+/status/\d+', input_data['text'])
if twitter_links:
    out['twitter_link'] = twitter_links[0]
else:
    out['twitter_link'] = ''

# --------------------------------------------------------
# Atomic Text
# --------------------------------------------------------
def delete_trailing_space(text):
  text = re.sub(r'^[\s\n]+|[\s\n]+$', '', text)
  return text

def delete_url(text):
  text = re.sub(r'https?://[^\s]+', '', text)
  return text

atomic_text = input_data['text']
atomic_text = delete_custom_tag(atomic_text)
atomic_text = delete_trailing_space(atomic_text)
atomic_text = delete_hashtag(atomic_text)

image_url_match_regexp = re.compile(r'(https://[^\s]+\.(png|jpg|gif)(\?[^\s]+)?)')

out['_atomic_text'] = atomic_text
out['_atomic_text_len'] = len(delete_url(atomic_text).split("\n"))

if out['_atomic_text_len'] == 1:
    atomic_text = re.sub(r'。', "。\n", atomic_text, 1)

out['title'] = atomic_text.split("\n")[0]
out['body'] = "\n".join(atomic_text.split("\n")[1:])

out['atomic_text_markdown_title'] = '# ' + out['title']
out['atomic_text_markdown_body'] = re.sub(image_url_match_regexp, '![image](\\1)', out['body'])
out['atomic_text_markdown'] = out['atomic_text_markdown_title'] + "\n\n" + out['atomic_text_markdown_body']


# --------------------------------------------------------
# Blog
# --------------------------------------------------------


splitted_body = custom_tags_deleted_text.split(text_split_mark)[1:]
splitted_body = list(filter(str.strip, splitted_body))

out['blog_text_group'] = []

image_url_match_regexp = re.compile(r'(https://[^\s]+\.(png|jpg|gif)(\?[^\s]+)?)')

text_line_count = 1
for i, splitted_text in enumerate(splitted_body):
  splitted_text = re.sub(image_url_match_regexp, '![image](\\1)', splitted_text)
  if (text_line_count+2) % 3 == 0:
      out['blog_text_group'].append('# ' + splitted_text + text_split_mark)
  else:
      out['blog_text_group'].append(splitted_text + text_split_mark)

  text_line_count += 1

out['blog_text'] = out['markdown_text'] = "\n\n".join(out['blog_text_group'])

if len(out['public_image_markdown']) > 0:
    out['markdown_text'] = out['blog_text'] + "\n" + out['public_image_markdown']
else:
    out['markdown_text'] = out['blog_text']

default_tags = 'japanese,blogger,zen,hatena-3min'

if match_tags:
    out['zen_tags'] = match_tags[1] + ',' + default_tags
else:
    out['zen_tags'] = default_tags

ja_diary_title = 'いなうらゆうま はここにいた'

out['ja_diary_title'] = ja_diary_title + ' ' + out['jst_date']
out['en_diary_title'] = 'And Then There Were None ' + out['jst_date']

# out['ja_engineer_diary_title'] = out['slack_channel_topic'] + ' ' + out['jst_date']

output = [out]

print(json.dumps(out))

