#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"
api_dir="${basedir}/../../lib"

github_repository="playground"

slack_message_json=$("${basedir}/channel-history.sh")
slack_messages=$(echo "$slack_message_json" | jq '.["messages"]')

if [ "$slack_messages" == "[]" ] || [ -z "$slack_messages" ]; then
  echo No slack messages found
  exit
fi

date=$(TZ=Asia/Tokyo date +'%Y-%m-%d')

github_title="いなうらゆうまはここにいた ${date}"

github_issues=$(
  OWNER=YumaInaura \
  REPOSITORY=playground \
  python "$api_dir"/github/issue.py
)

echo "$github_issues"

found_issues=$(echo "$github_issues" | jq -c 'select(.["title"] | contains("'"$github_title"'"))')

echo "FOUND ISSUES"
echo "$found_issues"

found_top_issue=$(echo "$found_issues" | head -n 1)

echo "FOUND TOP ISSUE"
echo "$found_top_issue" | jq .

if [ ! -z "$found_top_issue" ]; then
  title=$(echo "$found_top_issue" | jq --raw-output '.["title"]')
  body=$(echo "$found_top_issue" | jq --raw-output '.["body"]')$slack_message
  issue_number=$(echo "$found_top_issue" | jq '.["number"]')
 
  github_issue=$(
    USERNAME=YumaInaura \
    PASSWORD="$github_api_key" \
    REPOSITORY="$github_repository" \
    TITLE="$title" \
    BODY="$body" \
    ISSUE_NUMBER="$issue_number" \
    python "$api_dir"/github/create-or-edit-issue.py
  )
else
  body=$slack_message

  github_issue=$(
    USERNAME=YumaInaura \
    PASSWORD="$github_api_key" \
    REPOSITORY="$github_repository" \
    TITLE="$github_title" \
    BODY="$body" \
    DEBUG=1 python "$api_dir"/github/create-or-edit-issue.py
  )
fi

echo "CREATE OR EDITED ISSUE"
echo "$github_issue"

#pushd "$api_dir"
  # echo "$slack_message" | python ./twitter/oneline-split.py | ./twitter/create.sh 
#popd

