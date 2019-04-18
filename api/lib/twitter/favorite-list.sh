#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

"$base_dir"/common.py \
  'https://api.twitter.com/1.1/favorites/list.json' \
  '{ "user_name": "yumainaura", "include_entities": true, "count": 200 }'

