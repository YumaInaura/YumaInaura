#!/usr/bin/env bash

# https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/post-favorites-destroy

set -eu

tweet_id="$1"

base_dir=$(dirname "$0")

POST=1 \
"$base_dir"/common.py \
  'https://api.twitter.com/1.1/favorites/destroy.json' \
  '{ "id" : "'"$tweet_id"'" }'

