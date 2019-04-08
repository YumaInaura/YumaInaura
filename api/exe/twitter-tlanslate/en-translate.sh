#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

rm -f "$log_dir"/en-text.log
for ja_text in "$(cat "$log_dir"/ja-text.log)"; do
  echo "$ja_text" | "$api_dir"/google-translate/translate.sh | perl -pe 's/^"|"$//g' >> "$log_dir"/en-text.log
done

cat "$log_dir"/en-text.log

