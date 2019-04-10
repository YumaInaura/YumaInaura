#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

cat "$log_dir"/en-translated.json | \
  jq ' "https://twitter.com/YumaInaura/status/" +  .[].id_str + " " + .[].translated_text' | \
  jq '[{ "text" : . }]' | \
  tee "$log_dir"/en-tweet-seed.json

