#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

cat "$log_dir"/issue.json \
  | jq '[.[] | select(.labels[] | .name == "en-translate")]' \
  | tee "$log_dir"/en-need-translate-issue.json

