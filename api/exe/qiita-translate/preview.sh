#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"
source "${base_dir}/setting.sh"

mkdir -p "$log_dir"

character_length=0
article_num=0

character_length_lines=$(cat "$log_dir"/"$QIITA_ITEMS_USER_NAME".json | jq '.[].body | length')

for i in $character_length_lines; do
  article_num=$((article_num+1))
  character_length=$((character_length+i))
done

cat "$log_dir"/"$QIITA_ITEMS_USER_NAME".json | jq -r '"- " + .[].title'

echo -e "\n"

echo "$article_num" articles
echo "$character_length" character length


