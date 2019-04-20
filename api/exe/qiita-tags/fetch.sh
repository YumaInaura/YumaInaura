#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

QIITA_TAGS_ROUND=30 \
  "$api_dir"/qiita/tags.py \
  | tee "$log_dir"/tags.json 

