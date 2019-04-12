#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

cat "$log_dir"/need-en-translate-issue.json \
  | FROM=ja TO=en TRANSLATE_JSON_KEY=body \
    "$api_dir"/google-translate/translate-json.sh \
  | tee "$log_dir"/en-translate-issue.json

