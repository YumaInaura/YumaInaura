#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

USER_ID="473780756"
cat "$log_dir"/ja-timeline-filter-api-resource.json \
  | OWN_USER_ID="$USER_ID" "$api_dir"/twitter/filter-own.py \
  | tee "$log_dir"/ja-timeline-own.json

