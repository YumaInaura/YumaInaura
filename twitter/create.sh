#!/usr/bin/env bash

status_id=''

while read line
do
  result=$(echo "$line" | IN_REPLY_TO_STATUS_ID="$status_id" python3 twitter/create.py)
  echo "$result"
  status_id=$(echo "$result" | jq --raw-output '.["id_str"]')
  sleep 15
done 

