#!/usr/bin/env bash

set -x
set -u

mkdir -p log

timeline_file=log/last-timeline.log
markdown_file=log/markdown.md
url_list_file=log/url-list.log

# Generate Timeline Json
python timeline.py > "$timeline_file"

# Generate Markdown
cat "$timeline_file" | python markdown.py > "$markdown_file"

# Generate URL list
cat "$timeline_file" | jq --raw-output .id_str | xargs -L 1 -I :ID: echo "https://twitter.com/YumaInaura/status/:ID:" > "$url_list_file"

