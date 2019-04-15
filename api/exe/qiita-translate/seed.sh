#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"
source "${base_dir}/setting.sh"

cat "$log_dir"/"$QIITA_ITEMS_USER_NAME"_translated.json \
  | "$base_dir"/seed.py \
  | tee "$log_dir"/"$QIITA_ITEMS_USER_NAME"_seed.json
