#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

cat "$log_dir"/ja-timeline-recent.json | \
  jq '.[] | "https://twitter.com/YumaInaura/status/" +  .id_str + " " + .full_text' | \
  tee "$log_dir"/ja-text.log

