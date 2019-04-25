#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

mkdir -p "$log_dir"
rm -f "$log_dir"/*

source ~/.secret/env/twitter-yumainaura

ALL=1 \
ROUND=1 \
  "$api_dir"/twitter/timeline.sh \
  > "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json

last_ts=$(cat "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json | jq '.[].ts' | sort | tail -n 1)

interval_ts=$(($(date +%s) - $((30*60))))

if [ $last_ts -eq "$interval_ts" ]; then
  echo last ts "$last_ts" '< interval ts' "$interval_ts"
  exit 1
else
  echo last ts "$last_ts" '>= interval ts' "$interval_ts"
fi


