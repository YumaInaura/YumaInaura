#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

"$api_dir"/twitter/user-show.sh "$TWITTER_JA_USER_NAME" \
  | jq '[.]' \
  | "$api_dir"/twitter/user-show-markdown.py \
  | tee "$log_dir"/yumainaura.md

"$api_dir"/twitter/user-show.sh "$TWITTER_EN_USER_NAME" \
  | jq '[.]' \
  | "$api_dir"/twitter/user-show-markdown.py \
  | tee "$log_dir"/yumainaura2nd.md


