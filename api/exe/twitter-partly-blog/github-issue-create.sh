#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

history_dir="$base_dir"/history
mkdir -p "$history_dir"

jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%Y-%m-%d')

REPOSITORY=${REPOSITORY:-YumaInaura}

if [ ! -f "$log_dir"/github-issue-title-"$TWITTER_JA_USER_NAME".txt ]; then
  echo No markdown title file
  exit 1
fi

if [ -f "$log_dir"/all-user-profiles-"$TWITTER_JA_USER_NAME".md  ]; then
  cat "${log_dir}/github-issue-body-"$TWITTER_JA_USER_NAME".md" \
    "$log_dir"/all-user-profiles-"$TWITTER_JA_USER_NAME".md \
    > "${log_dir}/github-issue-body-all-"$TWITTER_JA_USER_NAME".md"
else
  cp "${log_dir}/github-issue-body-"$TWITTER_JA_USER_NAME".md" \
     "${log_dir}/github-issue-body-all-"$TWITTER_JA_USER_NAME".md"
fi

cat "${log_dir}/github-issue-body-all-"$TWITTER_JA_USER_NAME".md"

title=$(cat "$log_dir"/github-issue-title-"$TWITTER_JA_USER_NAME".txt)

export OWNER=YumaInaura \
       REPOSITORY="$REPOSITORY" \
       API_KEY="$github_api_key" \
       TITLE="$title" \
       FILE="${log_dir}/github-issue-body-all-"$TWITTER_JA_USER_NAME".md" \
       LABELS=medium,hatena,japanese,twitter,en-translate

"${api_dir}/github/create-or-edit-issue.py"

cat "$log_dir"/countable-"$TWITTER_JA_USER_NAME".json \
  | jq -r '.[0].id_str' \
  >> "$history_dir"/created-issue-title-tweet-id-"$TWITTER_JA_USER_NAME".txt

