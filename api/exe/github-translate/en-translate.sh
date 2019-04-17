#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

cat "$log_dir"/en-need-translate-issue.json \
  | \
    FORMAT=html \
    TRANSLATE_JSON_KEY=formatted_html,title \
      "$api_dir"/google-translate/translate-markdown.sh \
  | tee "$log_dir"/en-translated.json

