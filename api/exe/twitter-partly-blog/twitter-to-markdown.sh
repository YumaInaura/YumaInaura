#!/usr/bin/env bash

set -eu


base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"
jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%Y-%m-%d')

mkdir -p "$log_dir"
rm -rf "$log_dir"/*

source ~/.secret/env/twitter-yumainaura

tweet_border=3

interval_second=${INTERVAL:-3600}
start_unixtimestamp=$(($(date +%s) - $((3*60*60)) - $interval_second))
end_unixtimestamp=$(($(date +%s) - $((3*60*60))))

ALL=1 \
ROUND=1 \
  "$api_dir"/twitter/timeline.sh \
  > "$log_dir"/timeline-"$TWITTER_JA_USER_NAME".json

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

cat "$log_dir"/recent-"$TWITTER_JA_USER_NAME".json \
  | "$api_dir"/twitter/format-customed-mark.py \
  > "$log_dir"/formatted-"$TWITTER_JA_USER_NAME".json

cat "$log_dir"/formatted-"$TWITTER_JA_USER_NAME".json \
  | jq '[.[] | select(.in_reply_to_status_id == null)]' \
  | jq '[.[] | select(.full_text | contains("on Twitter") | not)]' \
  > "$log_dir"/countable-"$TWITTER_JA_USER_NAME".json

cat "$log_dir"/countable-"$TWITTER_JA_USER_NAME".json \
  | jq 'sort_by(.favorite_count) | reverse' \
  > "$log_dir"/forvorite-desc-"$TWITTER_JA_USER_NAME".json

countable_tweet_num=$(cat "$log_dir"/countable-"$TWITTER_JA_USER_NAME".json | jq length)
if [ $countable_tweet_num -lt $tweet_border ]; then
  echo Tweets num under "$countable_tweet_num" / "$tweet_border" 
  exit 1
fi

echo \
  $(
    cat "$log_dir"/forvorite-desc-"$TWITTER_JA_USER_NAME".json \
      | jq -r '.[0].full_text_without_quoted_url' \
      | head -n 1
  ) \
  " $jst_date on Twitter" \
  | tee "$log_dir"/github-issue-title-"$TWITTER_JA_USER_NAME".txt

cat "$log_dir"/formatted-"$TWITTER_JA_USER_NAME".json \
  | jq 'sort_by(.favorite_count) | reverse' \
  | "$api_dir"/twitter/markdown.py \
  | tee "$log_dir"/github-issue-body-"$TWITTER_JA_USER_NAME".md

