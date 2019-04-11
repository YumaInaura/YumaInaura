#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

if [ ! -f "$log_dir"/en-translated.json ]; then
  echo "no en tralslated file"
  exit
fi

cat "$log_dir"/en-translated.json | \
  "$base_dir"/en-seed.py | \
  tee "$log_dir"/en-seed.json 

