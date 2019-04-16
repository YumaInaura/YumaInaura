#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"
source "${base_dir}/setting.sh"

cat "$log_dir"/"$QIITA_ITEMS_USER_NAME"-translated.json \
  | "$base_dir"/create-seed.py \
  | tee "$log_dir"/"$QIITA_ITEMS_USER_NAME"-create-seed.json

