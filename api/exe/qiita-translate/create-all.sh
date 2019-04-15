#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"
source "${base_dir}/setting.sh"

mkdir -p "$log_dir"

cat "$log_dir"/"$QIITA_ITEMS_USER_NAME"_translated_test.json \
  "$api_dir"/qiita/

