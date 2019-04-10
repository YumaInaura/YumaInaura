#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

cat "$log_dir"/en-translate.json | \
  "$base_dir"/format-translate.py | \
  tee "$log_dir"/en-seed.json 

