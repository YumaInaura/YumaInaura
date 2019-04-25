#!/usr/bin/env bash

set -eu


base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

mkdir -p "$log_dir"

source ~/.secret/env/twitter-yumainaura

ALL=1 \
ROUND=1 \
  "$api_dir"/twitter/timeline.sh \
  > "$log_dir"/timeline-"$twitter_ja_user_name".json

last_ts=$(cat "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json | jq '.[].ts' | sort | tail -n 1)

interval_ts=$(($(gdate +%s) - $((30*60))))

if [ -eq  ];
  echo last ts "$last_ts" < interval ts "$interval_ts"
  exit 1
fi

