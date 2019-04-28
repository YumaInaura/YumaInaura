#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

mkdir -p "$log_dir"
rm -f "$log_dir"/*

mkdir -p "$base_dir"/history

source ~/.secret/env/twitter-yumainaura

ALL=1 \
ROUND=1 \
  "$api_dir"/twitter/timeline.sh \
  > "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json

