#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%Y-%m-%d')


tweet_border=${TWEET_BORDER:-3}

countable_tweet_num=$(cat "$log_dir"/countable-"$TWITTER_JA_USER_NAME".json | jq length)
if [ $countable_tweet_num -lt $tweet_border ]; then
  echo Tweets num under "$countable_tweet_num" / "$tweet_border" 
  exit 1
fi

title_core=$(
  cat "$log_dir"/farvorite-desc-"$TWITTER_JA_USER_NAME".json \
        | jq -r '.[0].full_text_without_quoted_url' \
        | head -n 1
)

echo "$title_core"

echo "$title_core $jst_date on Twitter" \
  | tee "$log_dir"/github-issue-title-"$TWITTER_JA_USER_NAME".txt

cat  "$log_dir"/profile-seed-"$TWITTER_JA_USER_NAME".json \
  | jq 'sort_by(.favorite_count) | reverse' \
  | "$api_dir"/twitter/markdown.py \
  | tee "$log_dir"/github-issue-body-"$TWITTER_JA_USER_NAME".md


