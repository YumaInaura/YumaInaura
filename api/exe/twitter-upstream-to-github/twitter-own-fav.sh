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

cat "$log_dir"/own-favorites.json \
  | jq -r '.[0].id_str' \
  | tee "$log_dir"/own-favorite-tweet-id.log

# "$api_dir"/twitter/upstream-tweet-chain.py "$tweet_id" \
#   > "$log_dir"/upstream-tweets-by-like.json
# 
# cat "$log_dir"/upstream-tweets-by-like.json \
#   | jq reverse \
#   | "$api_dir"/twitter/format-customed-mark.py \
#   | "$api_dir"/twitter/markdown.py \
#   > "$log_dir"/github-body.md
# 
# cat "$log_dir"/upstream-tweets-by-like.json \
#   | jq --raw-output '.[0].full_text' \
#    > "$log_dir"/github-title.txt
# 
# export OWNER=YumaInaura \
#        REPOSITORY=YumaInaura \
#        API_KEY=$(cat ~/.secret/github-api-key) \
#        TITLE=$(cat "$log_dir"/upstream-tweets-by-like.md) \
#        FILE="$log_dir"/upstream-tweets-by-like.md \
#        LABELS=medium,hatena,japanese,twitter
# 
# # "${api_dir}/github/create-or-edit-issue.py"
# 
