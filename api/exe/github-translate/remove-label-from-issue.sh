#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

cat "$log_dir"/remove-label-from-issue-seed.json \
 | "$api_dir"/github/edit-issue.py \
 | tee "$log_dir"/removed-label-from-issue.json

