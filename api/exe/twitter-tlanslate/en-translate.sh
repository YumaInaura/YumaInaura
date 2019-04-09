#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

rm -f "$log_dir"/en-text.log

i=1
for ja_text in echo $(cat "$log_dir"/ja-text.log); do
  # echo "$ja_text" | "$api_dir"/google-translate/translate.sh >> "$log_dir"/en-text_"$i".log
  echo "$ja_text"
  echo $i
  i=$((i+i))
done

#cat "$log_dir"/en-text.log

