import time, re
from datetime import datetime
from datetime import timedelta

out = {}

out['raw_text'] = input['text']

def add_hashtag_to_text(text):
    hash_keywords = [
        '天才',
        'ゲーム',
        '脊柱管狭窄',
        '恋愛',
        'エネルギー',
        '人生',
        'ADHD',
        '妻',
        'エンジニア',
        'ライフハック',
        'クリエイティブ',
        'カフェ',
        'アート',
        'スクラム',
        '睡眠',
        'マインドフルネス',
        '聴覚過敏',
        '記録',
        '記憶',
        'スターバックス',
        'スタバ',
        'マクドナルド',
        '哲学',
        '日本語',
    ]
    hashtaged_text = text
    for hash_keyword in hash_keywords:
        hashtaged_text =  re.sub(
            r'(?<!#)' + hash_keyword,
            ' ' + '#' + hash_keyword + ' ',
            hashtaged_text
        )

    return hashtaged_text


out['first_line_text'] = input_data['text'].split("\n")[0]

match_tags = re.search(r'tags:([a-zA-Z0-9,]+)', input['text'])
custom_tags_deleted_text = out['custom_tags_deleted_text'] = re.sub(r'tags:([a-zA-Z0-9,]+)', '', out['first_line_text'])
formatted_text = out['formatted_text'] = re.sub(r'[#\s]', '', custom_tags_deleted_text)
out['text_for_translate'] = out['formatted_text'][:900] + (out['formatted_text'][900:] and '..')

now = datetime.now()
text_split_mark = "。"

out['jst_date'] = (datetime.now() + timedelta(hours=9)).strftime('%Y-%m-%d')

out['unixtime'] = int(time.mktime(now.timetuple()))


out['newline_text'] = formatted_text.replace(r'。', "。\n\n")
out['title'] = custom_tags_deleted_text.split(text_split_mark)[0]

out['text_length'] = len(custom_tags_deleted_text)

hashtaged_text = add_hashtag_to_text(custom_tags_deleted_text)


twitter_links = re.search(r'https://twitter.com/\w+/status/\d+', input['text'])

if twitter_links:
    out['twitter_text'] = (hashtaged_text[:100] + (hashtaged_text[100:] and '..'))
    out['twitter_link'] = twitter_links[0]
else:
    out['twitter_text'] = hashtaged_text[:120] + (hashtaged_text[120:] and '..')
    out['twitter_link'] = ''


out['truncated_text'] = custom_tags_deleted_text[:120] + (custom_tags_deleted_text[120:] and '..')


splitted_body = custom_tags_deleted_text.split(text_split_mark)[1:]
splitted_body = list(filter(str.strip, splitted_body))

blog_text = []
for i, splitted_text in enumerate(splitted_body):
  if i % 4 == 0:
    blog_text.append('# ' + splitted_text + text_split_mark)
  else:
    blog_text.append(splitted_text + text_split_mark)

out['blog_text_group'] = blog_text
out['blog_text'] = out['markdown_text'] = "\n\n".join(blog_text)

out['text'] = \
    out['first_line_text'].split('。')[0] + \
    "。" + \
    "\n" + \
    "。".join(input_data['text'].split('。')[1:-1]) + \
    "。"


default_tags = 'japanese,blogger,zen,hatena-3min'

if match_tags:
    out['zen_tags'] = match_tags[1] + ',' + default_tags
else:
    out['zen_tags'] = default_tags

out['ja_diary_title'] = 'いなうらゆうまはここにいた ' + out['jst_date']
out['en_diary_title'] = 'Yuma Inaura Was Here ' + out['jst_date']


output = [out]

