#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8
base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"

"$api_dir"/twitter/user-show.sh 'YumaInaura' \
  | tee "$log_dir"/yumainaura-user-profile.json

