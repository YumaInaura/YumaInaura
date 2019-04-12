#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/prepare.sh"

message=$(cat "$markdown_text_log_file")

if [ -z "$message" ]; then
  echo No resouce message for tralslate so nothing to do
  exit
fi

token=$(eval "$api_dir"/google-translate/get-token.sh)

export TOKEN="$token"

echo "$message" | \
  FROM=ja \
  TO=en \
  "$api_dir"/google-translate/translate.py | \
  jq --raw-output '.data.translations[].translatedText' | \
  tee "$google_translate_en_log_file" 

echo "$message" | \
  FROM=ja \
  TO=zh-CN \
  "$api_dir"/google-translate/translate.py | \
  jq --raw-output '.data.translations[].translatedText' | \
  tee "$google_translate_tw_log_file" 

echo "$message" | \
  FROM=ja \
  TO=hi \
  "$api_dir"/google-translate/translate.py | \
  jq --raw-output '.data.translations[].translatedText' | \
  tee "$google_translate_hi_log_file" 

