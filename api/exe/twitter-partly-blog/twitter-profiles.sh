#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

rm -f "$log_dir"/all-user-profiles-"$TWITTER_JA_USER_NAME".md

cat "$log_dir"/profile-seed-"$TWITTER_JA_USER_NAME".json \
  | jq '[.[] | select(.ext.quoted_user_screen_name)]' \
  | jq -r '.[].ext.quoted_user_screen_name' \
  | sort \
  | uniq \
  > "$log_dir"/quoted-user-screen-names-"$TWITTER_JA_USER_NAME".txt

if [ -f "$log_dir"/quoted-user-screen-names-"$TWITTER_JA_USER_NAME".txt ]; then
  echo -e "# 引用させていただいた方々\n\n" \
    >> "$log_dir"/all-user-profiles-"$TWITTER_JA_USER_NAME".md

  for display_name in $(cat "$log_dir"/quoted-user-screen-names-"$TWITTER_JA_USER_NAME".txt); do
    "$api_dir"/twitter/user-show.sh "$display_name" \
    | "$api_dir"/twitter/markdown-user.py \
    >> "$log_dir"/all-user-profiles-"$TWITTER_JA_USER_NAME".md
  done
fi

cat "$log_dir"/all-user-profiles-"$TWITTER_JA_USER_NAME".md


