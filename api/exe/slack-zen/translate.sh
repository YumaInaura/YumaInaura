#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/prepare.sh"

message=$(cat /dev/stdin)

token=$(eval "$api_dir"/google-translate/get-token.sh)

export TOKEN="$token"

echo "$message" | \
  FROM=ja \
  TO=en \
  "$api_dir"/google-translate/translate.py | \
  tee "$google_translate_en_log_file" 

echo "$message" | \
  FROM=ja \
  TO=zh-CN \
  "$api_dir"/google-translate/translate.py | \
  tee "$google_translate_tw_log_file" 

echo "$message" | \
  FROM=ja \
  TO=hi \
  "$api_dir"/google-translate/translate.py | \
  tee "$google_translate_hi_log_file" 

