#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

rm -f "$log_dir"/en-text-trancate.log

for en_text in "$(cat "$log_dir"/en-text.log)"; do
  echo "$en_text" | perl -pe 's/^(.{280}).+/\1/g' >> "$log_dir"/en-text-trancate.log
done

cat "$log_dir"/en-text-trancate.log

