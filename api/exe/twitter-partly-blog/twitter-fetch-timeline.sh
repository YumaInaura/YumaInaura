#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"
jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%Y-%m-%d')

mkdir -p "$log_dir"
rm -rf "$log_dir"/*

source ~/.secret/env/twitter-yumainaura

ALL=1 \
ROUND=1 \
  "$api_dir"/twitter/timeline.sh \
  > "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json

