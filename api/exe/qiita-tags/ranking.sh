#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

cat "$log_dir"/tags.json \
  | jq -r '.[] | "1. [" + .id + "](https://qiita.com/tags/" + .id + ") " + (.items_count | tostring) + " items"' \
  | tee "$log_dir"/ranking.md

