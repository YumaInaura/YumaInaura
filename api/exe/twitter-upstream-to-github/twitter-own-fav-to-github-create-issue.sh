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

"$api_dir"/twitter/upstream-tweet-chain.py "$tweet_id" \
  > "$log_dir"/upstream-tweets-by-like.json

cat "$log_dir"/upstream-tweets-by-like.json \
  | "$api_dir"/twitter/markdown.py \
  | tee "$log_dir"/upstream-tweets-by-like.md

# cat "$log_dir"/en-seed.json \
#   | \
#     USER_NAME=YumaInaura \
#     API_KEY=$(cat ~/.secret/github-api-key) \
#       "$api_dir"/github/create-issue.py \
#   | tee "$log_dir"/en-created-issue.json

