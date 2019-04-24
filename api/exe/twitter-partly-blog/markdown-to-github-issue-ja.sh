#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

history_dir="$base_dir"/history
mkdir -p "$history_dir"

jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%Y-%m-%d')

REPOSITORY=${REPOSITORY:-YumaInaura}

if [ ! -f "$log_dir"/"$TWITTER_JA_USER_NAME"-issue-title.txt ]; then
  echo No markdown title file
  exit 1
fi

title=$(cat "$log_dir"/"$TWITTER_JA_USER_NAME"-issue-title.txt)

export OWNER=YumaInaura \
       REPOSITORY="$REPOSITORY" \
       API_KEY="$github_api_key" \
       TITLE="$title" \
       FILE="${log_dir}/"$TWITTER_JA_USER_NAME".md" \
       LABELS=medium,hatena,japanese,twitter

"${api_dir}/github/create-or-edit-issue.py"

cat "$log_dir"/"$TWITTER_JA_USER_NAME"-countable.json \
  | jq -r '.[0].id_str' \
  >> "$history_dir"/"$TWITTER_JA_USER_NAME"-created-issue-title-tweet-id.txt

