#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

if [ ! -f "$log_dir"/en-translated.json ]; then
  echo "no en tralslated file"
  exit
fi

cat "$log_dir"/en-translated.json | \
  > "$log_dir"/ja-en-seed.json 

cat "$log_dir"/en-translated.json | \
  DICTIONARY_JSON_KEY=id \
  HASHTAG_JSON_KEY=full_text \
    "$api_dir"/twitter/add-hashtag.py \
      "$base_dir"/../../exe/qiita-tags/log/english-tags.json \
  > "$log_dir"/ja-en-seed.json 

cat "$log_dir"/en-translated.json | \
  "$base_dir"/ja-en-seed.py | \
  tee "$log_dir"/ja-en-seed.json 


