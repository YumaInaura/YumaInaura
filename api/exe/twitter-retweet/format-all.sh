#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

last_ts=$(cat "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json | jq '.[].ts' | sort | tail -n 1)

interval_ts=$(($(date +%s) - $((30*60))))

if [ $last_ts -eq "$interval_ts" ]; then
  echo last ts "$last_ts" '< interval ts' "$interval_ts"
  exit 1
else
  echo last ts "$last_ts" '>= interval ts' "$interval_ts"
fi

cat "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json \
  | jq '[.[] | select(.retweeted)]' \
  | tee "$log_dir"/retweeted-"$TWITTER_JA_USER_NAME".json

cat "$log_dir"/retweeted-"$TWITTER_JA_USER_NAME".json \
  | jq -r '.[].id_str' \
  | shuf \
  | head -n 1 \
  | tee "$log_dir"/retweet-id-"$TWITTER_JA_USER_NAME".txt

