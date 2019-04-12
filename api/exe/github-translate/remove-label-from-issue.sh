#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

cat "$log_dir"/en-need-translate-issue.json \
 | \
    FORMAT=text \
    TOKEN=$("$api_dir"/google-translate/get-token.sh) \
    TRANSLATE_JSON_KEY=title \
    TRANSLATED_JSON_KEY=en_translated_title \
      "$api_dir"/google-translate/translate-json.py \
  | tee "$log_dir"/en-translated.json


