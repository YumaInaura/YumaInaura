#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

"$api_dir"/twitter/favorite-list.sh \
  | jq '[.[] | select(.user.name == "'"$TWITTER_JA_USER_NAME"'")]'

