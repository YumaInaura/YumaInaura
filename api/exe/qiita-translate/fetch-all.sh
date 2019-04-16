#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"
source "${base_dir}/setting.sh"

mkdir -p "$log_dir"

QIITA_ITEMS_ROUND=30 \
  "$api_dir"/qiita/items.py \
  | tee "$log_dir"/"$QIITA_ITEMS_USER_NAME".json

