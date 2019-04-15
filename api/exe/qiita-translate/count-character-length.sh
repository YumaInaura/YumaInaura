#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"
source "${base_dir}/setting.sh"

mkdir -p "$log_dir"

count=0

for i in $(cat "$log_dir"/"$qiita_items_user_name".json | jq '.[].body | length'); do
  count=$((count+i));
done

echo $count

