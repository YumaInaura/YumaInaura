#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8
base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"
jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%y-%m-%d')

mkdir -p "$log_dir"

source ~/.secret/env/twitter-yumainaura2nd

ALL=1 "$api_dir"/twitter/timeline.sh \
  > "$log_dir"/timeline-yumainaura-2nd.json

cat "$log_dir"/timeline-yumainaura-2nd.json \
  | OWN_USER_ID="$TWITTER_EN_USER_ID" "$api_dir"/twitter/filter-own.py \
  > "$log_dir"/timeline-own-tweet-yumainaura2nd.json

cat "$log_dir"/timeline-own-tweet-yumainaura2nd.json \
  | "$api_dir"/twitter/jst-datetime-filter.py \
  > "$log_dir"/timeline-jst-yesterday-yumainaura2nd.json

"$api_dir"/twitter/user-show.sh "$TWITTER_EN_USER_NAME" \
  | jq '[.]' \
  | "$api_dir"/twitter/user-show-markdown.py \
  > "$log_dir"/"$TWITTER_EN_USER_NAME".md


cat "$log_dir"/timeline-jst-yesterday-yumainaura2nd.json \
  | PERIOD='\\.' "$api_dir"/twitter/markdown.py \
  >> "$log_dir"/"$TWITTER_EN_USER_NAME".md

