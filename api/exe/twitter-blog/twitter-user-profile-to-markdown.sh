#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"

"$api_dir"/twitter/user-show.sh 'yumainaura' \
  | jq '[.]' \
  | "$api_dir"/twitter/user-show-markdown.py \
  | tee "$log_dir"/yumainaura.md

"$api_dir"/twitter/user-show.sh 'yumainaura2nd' \
  | jq '[.]' \
  | "$api_dir"/twitter/user-show-markdown.py \
  | tee "$log_dir"/yumainaura2nd.md


