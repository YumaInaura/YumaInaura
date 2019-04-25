#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

last_ts=$(cat "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json | jq '.[].ts' | sort | tail -n 1)

interval_ts=$(($(date +%s) - $((30*60))))

if [ $interval_ts -gt $last_ts ]; then
  :
else
  echo Stop
  echo last ts "$last_ts" '< interval ts' "$interval_ts"
  exit 1
fi

cat "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json \
  | jq '[.[] | select(.retweeted)]' \
  | tee "$log_dir"/not-retweeted-"$TWITTER_JA_USER_NAME".json

cat "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json \
  | jq '[.[] | select(.retweeted)]' \
  | tee "$log_dir"/retweeted-"$TWITTER_JA_USER_NAME".json

cat "$log_dir"/retweeted-"$TWITTER_JA_USER_NAME".json \
  | jq -r '.[].retweeted_status.id_str' \
  | shuf \
  | head -n 1 \
  | tee "$log_dir"/retweet-id-"$TWITTER_JA_USER_NAME".txt

echo last ts "$last_ts" '>= interval ts' "$interval_ts"
