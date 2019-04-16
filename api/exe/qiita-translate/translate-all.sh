#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"
source "${base_dir}/setting.sh"

mkdir -p "$log_dir"

filter_start=${FILTER_START:-1}
filter_start=$((filter_start-1))

filter_end=${FILTER_END:-5}

cat "$log_dir"/"$QIITA_ITEMS_USER_NAME".json \
  | jq '.['"$filter_start"':'"$filter_end"']' \
  | "$api_dir"/google-translate/translate-markdown.sh \
  | tee "$log_dir"/"$QIITA_ITEMS_USER_NAME"-translated.json

