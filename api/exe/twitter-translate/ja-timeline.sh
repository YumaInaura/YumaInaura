#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

mkdir -p "$log_dir"

source ~/.secret/env/twitter-yumainaura

ALL=1 ROUND=1 \
  "$api_dir"/twitter/timeline.sh \
  | TWITTER_USER_NAME=YumaInaura "$api_dir"/twitter/timeline-add-ext.py \
  | tee "$log_dir"/ja-timeline.json

