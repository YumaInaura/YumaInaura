#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

cat "$log_dir"/en-need-translate-issue.json \
  | \
    FORMAT=text \
    TRANSLATE_JSON_KEY=title \
    TRANSLATED_JSON_KEY=title \
      "$api_dir"/google-translate/translate-json.sh \
  > "$log_dir"/en-translated-title.json

cat "$log_dir"/en-translated-title.json \
  | \
    TRANSLATE_JSON_KEY=body \
      "$api_dir"/google-translate/translate-markdown.sh \
  | tee "$log_dir"/en-translated.json

