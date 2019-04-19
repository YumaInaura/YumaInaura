#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

tweet_id=$(cat "$log_dir"/own-favorite-tweet-id.log)

"$api_dir"/twitter/favorite-destroy.sh "$tweet_id"

