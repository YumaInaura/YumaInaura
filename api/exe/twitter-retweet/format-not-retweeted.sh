#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

cat "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json \
  | jq '[.[] | select(.lang == "ja")]' \
  | jq '[.[] | select(.in_reply_to_user_id_str == null)]' \
  | tee "$log_dir"/not-retweeted-"$TWITTER_JA_USER_NAME".json
#  | jq '[.[] | select(.retweeted | not)]' \
#  | jq '[.[] | select(.favorite_count >= 3)]' \

cat "$log_dir"/not-retweeted-"$TWITTER_JA_USER_NAME".json \
  | jq -r '.[].id_str' \
  | shuf \
  | head -n 1 \
  | tee "$log_dir"/retweet-id-"$TWITTER_JA_USER_NAME".txt

