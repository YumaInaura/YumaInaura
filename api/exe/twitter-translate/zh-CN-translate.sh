#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

if [ $(cat "$log_dir"/ja-timeline-recent.json | jq '. | length') -eq 0 ]; then
  echo "No translate resource"
  exit 1
fi

cat "$log_dir"/ja-timeline-recent.json | \
  TRANSLATE_JSON_KEY=full_text \
  FROM=ja TO=zh-CN \
    "$api_dir"/google-translate/translate-json.sh | \
  tee "$log_dir"/zh-CN-translated.json 

