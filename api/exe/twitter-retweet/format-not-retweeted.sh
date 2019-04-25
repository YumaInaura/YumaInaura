#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

cat "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json \
  | jq '[.[] | select(.retweeted | not)]' \
  | tee "$log_dir"/not-retweeted-"$TWITTER_JA_USER_NAME".json

cat "$log_dir"/retweeted-"$TWITTER_JA_USER_NAME".json \
  | jq -r '.[].retweeted_status.id_str' \
  | shuf \
  | head -n 1 \
  | tee "$log_dir"/retweet-id-"$TWITTER_JA_USER_NAME".txt

