#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

cat "$log_dir"/need-en-translate-issue.json \
  | "$base_dir"/en-translate.py \
  | tee "$log_dir"/en-translated.json


