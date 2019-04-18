#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

log_dir="$base_dir"/log
mkdir -p "$log_dir"

"$api_dir"/twitter/favorite-list.sh \
  | jq '[.[] | select(.user.screen_name == "'"$TWITTER_JA_USER_NAME"'")]' \
  | tee "$log_dir"/own-favorites.json

tweet_id=$(cat "$log_dir"/own-favorites.json | jq -r '.[0].id_str')

"$base_dir"/upstream-tweet-chain.sh "$tweet_id" \
  | tee "$log_dir"/tweet-upstream.json

