#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

source ~/.secret/env/twitter-yumainaura

retweet_id=$(cat "$log_dir"/retweet-id-"$TWITTER_JA_USER_NAME".txt)

"$api_dir"/twitter/post.py \
  'https://api.twitter.com/1.1/statuses/unretweet/'"$retweet_id"'.json'

sleep 1

"$api_dir"/twitter/post.py \
  'https://api.twitter.com/1.1/statuses/retweet/'"$retweet_id"'.json'

