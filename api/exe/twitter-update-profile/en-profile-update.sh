#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "$base_dir"/../twitter-setting.sh
source "$base_dir"/../../setting.sh
source ~/.secret/env/twitter-yumainaura2nd

"$api_dir"/twitter/update-profile.py \
  $(ls -1 "$base_dir"/image/*.jpg | shuf -n 1)

