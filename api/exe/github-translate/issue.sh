#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

mkdir -p "$log_dir"

OWNER=YumaInaura \
REPOSITORY=YumaInaura \
ROUND=1 \
  eval "$api_dir"/github/issue.py \
  > "$log_dir"/issue.json

