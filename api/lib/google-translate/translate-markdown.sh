#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

log_dir="$base_dir"/log
 
mkdir -p "$log_dir"

translate_json_key=${TRANSLATE_JSON_KEY:-text}

cat /dev/stdin \
  | \
    TRANSLATE_JSON_KEY="$translate_json_key" \
      "${base_dir}"/markdown-to-html.py \
  > "$log_dir"/en-seed-html.json

cat "$log_dir"/en-seed-html.json \
  | \
    TOKEN=$("$base_dir"/get-token.sh) \
    TRANSLATE_JSON_KEY="$translate_json_key" \
    TRANSLATED_JSON_KEY="$translate_json_key" \
    FORMAT=html \
    FROM=ja \
    TO=en \
      "$base_dir"/translate-json.py \
  > "$log_dir"/en-translated-html.json

cat "$log_dir"/en-translated-html.json \
  | \
    TRANSLATE_JSON_KEY="$translate_json_key" \
     "${base_dir}"/reverse-html-to-markdown.py \
  | tee "$log_dir"/en-translated-markdown.json

