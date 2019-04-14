#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "$base_dir"/../twitter-setting.sh
source "$base_dir"/../../setting.sh
source ~/.secret/env/twitter-yumainaura

"$api_dir"/twitter/update-profile.py \
  $(ls -1 "$base_dir"/image-sepia/* | shuf -n 1)

