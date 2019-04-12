#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"

"$api_dir"/twitter/user-show.sh 'YumaInaura' \
  | tee "$log_dir"/yumainaura-user-profile.json

