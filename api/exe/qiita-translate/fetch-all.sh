#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

QIITA_ITEMS_USER_NAME=YumaInaura \
QIITA_ITEMS_ROUND=30 \
  ./list.py \
  | tee > "$log_dir"/"$QIITA_ITEMS_USER_NAME".json


