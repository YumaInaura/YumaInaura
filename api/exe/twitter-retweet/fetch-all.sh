#!/usr/bin/env bash

set -eu


base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

mkdir -p "$log_dir"

source ~/.secret/env/twitter-yumainaura

interval_second=${INTERVAL:-3600}
start_unixtimestamp=$(($(date +%s) - $((3*60*60)) - $interval_second))
end_unixtimestamp=$(($(date +%s) - $((3*60*60))))

ALL=1 \
ROUND=1 \
  "$api_dir"/twitter/timeline.py \
  > "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json


