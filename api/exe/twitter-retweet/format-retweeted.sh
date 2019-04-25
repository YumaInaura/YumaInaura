#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

# last_ts=$(cat "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json | jq '.[].ts' | sort | tail -n 1)
#
# border_ts=$(($(date +%s) - $((30*60))))
#
# if [ $border_ts -lt $last_ts ]; then
#   echo Stop
#   echo 'border ts' "$border_ts" '< last ts' "$last_ts"
#   echo $(($last_ts - $border_ts)) second wait
#   exit 1
# fi

cat "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json \
  | jq '[.[] | select(.retweeted)]' \
  | jq '[.[] | select(.user.id_str != '"$TWITTER_JA_USER_ID"')]' \
  | tee "$log_dir"/retweeted-"$TWITTER_JA_USER_NAME".json

cat "$log_dir"/retweeted-"$TWITTER_JA_USER_NAME".json \
  | jq -r '.[].retweeted_status.id_str' \
  | shuf \
  | head -n 1 \
  | tee "$log_dir"/retweet-id-"$TWITTER_JA_USER_NAME".txt

