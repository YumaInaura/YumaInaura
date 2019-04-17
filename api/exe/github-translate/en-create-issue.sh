#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

cat "$log_dir"/en-seed.json \
  | \
    USER_NAME=YumaInaura \
    API_KEY=$(cat ~/.secret/github-api-key) \
    TITLE_JSON_KEY=en_translated_title \
    BODY_JSON_KEY=en_translated_body \
      "$api_dir"/github/create-issue.py \
  | tee "$log_dir"/en-created-issue.json

