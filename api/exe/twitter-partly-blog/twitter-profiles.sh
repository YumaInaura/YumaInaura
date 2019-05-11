#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

cat "$log_dir"/recent-"$TWITTER_JA_USER_NAME".json \
  | jq '[.[] | select(.quoted_status.entities.user_mentions)]' \
  | jq -r '.[].quoted_status.entities.user_mentions[].screen_name' \
  | sort \
  | uniq \
  > "$log_dir"/quoted-user-screen-names-"$TWITTER_JA_USER_NAME".txt

for display_name in $(cat "$log_dir"/quoted-user-screen-names-"$TWITTER_JA_USER_NAME".txt); do
  "$api_dir"/twitter/user-show.sh "$display_name" \
  | "$api_dir"/twitter/markdown-user.py
done

