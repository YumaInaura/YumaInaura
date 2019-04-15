#!/usr/bin/env bash

base_dir=$(dirname "$0")

log_dir="$base_dir"/log
 
mkdir -p "$log_dir"

cat /dev/stdin \
  | "${base_dir}"/markdown-to-html.py
  | > "$log_dir"/seed-markdown.json

TOKEN=$("$base_dir"/get-token.sh) \
  TRANSLATE_JSON_KEY=body \
  FORMAT=html \
  FROM=ja \
  TO=en \
    "$base_dir"/translate-json.py \
  | > "$log_dir"/en-translated.json

cat "$log_dir"/en-translated.json
  | "${base_dir}"/html-to-markdown.py
  | tee "$log_dir"/en-translated-markdown.json

