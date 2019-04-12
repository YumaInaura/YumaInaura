#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

cat "$log_dir"/en-need-translate-issue.json \
 | "$base_dir"/remove-label-from-issue-seed.py \
 | tee "$log_dir"/remove-label-from-issue-seed.json

