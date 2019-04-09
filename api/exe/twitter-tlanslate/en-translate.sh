#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

cat "$log_dir"/ja-test.json | \
  TRANSLATE_JSON_KEY=full_text "$api_dir"/google-translate/translate-json.sh | \
  tee "$log_dir"/en-translated.json 

