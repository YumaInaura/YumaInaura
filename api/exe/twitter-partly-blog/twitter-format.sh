#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

tweet_border=3

hour=${HOUR:-3}
interval_second=${INTERVAL:-3600}
start_unixtimestamp=$(($(date +%s) - $((hour*60*60)) - $interval_second))
end_unixtimestamp=$(($(date +%s) - $((hour*60*60))))

cat "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json \
  | \
  OWN_USER_ID="$TWITTER_JA_USER_ID" \
    "$api_dir"/twitter/filter-own.py \
  > "$log_dir"/own-"$TWITTER_JA_USER_NAME".json

lang="ja"
cat "$log_dir"/own-"$TWITTER_JA_USER_NAME".json \
  | jq '[.[] | select(.lang == "'"$lang"'")]' \
  > "$log_dir"/own-"$lang"-"$TWITTER_JA_USER_NAME".json

cat "$log_dir"/own-"$lang"-"$TWITTER_JA_USER_NAME".json \
  | "$api_dir"/twitter/filter-timestamp.py "$start_unixtimestamp" "$end_unixtimestamp" \
  > "$log_dir"/recent-"$TWITTER_JA_USER_NAME".json

cp "$log_dir"/recent-"$TWITTER_JA_USER_NAME".json \
  "$log_dir"/profile-seed-"$TWITTER_JA_USER_NAME".json

cat "$log_dir"/recent-"$TWITTER_JA_USER_NAME".json \
  | jq '[.[] | select(.in_reply_to_status_id == null)]' \
  | jq '[.[] | select(.full_text | contains("on Twitter") | not)]' \
  > "$log_dir"/countable-"$TWITTER_JA_USER_NAME".json

cat "$log_dir"/countable-"$TWITTER_JA_USER_NAME".json \
  | jq 'sort_by(.favorite_count) | reverse' \
  > "$log_dir"/farvorite-desc-"$TWITTER_JA_USER_NAME".json

echo "$log_dir"/farvorite-desc-"$TWITTER_JA_USER_NAME".json

