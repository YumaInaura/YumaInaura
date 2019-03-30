#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/prepare.sh"

message=$(cat /dev/stdin)

token=$(eval "$api_dir"/google-translate/get-token.sh)

echo "$message" | \
  TOKEN="$token" \
    "$api_dir"/google-translate/translate.py | \
    tee "$google_translate_en_log_file" 

