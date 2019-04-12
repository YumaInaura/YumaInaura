#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

cat "$log_dir"/en-need-translate-issue.json \
  | "$base_dir"/en-format.py \
  | tee "$log_dir"/en-format.json


