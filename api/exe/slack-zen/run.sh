#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"

api_dir="${basedir}/../../lib"
log_dir="${basedir}"/log

mkdir -p "${log_dir}"

github_repository="playground"

eval "${basedir}/channel-history.sh" > "$log_dir"/channel-message.json

cat "$log_dir"/channel-message.json | jq '.["messages"][]' > "$log_dir"/slack_message.json
cat "$log_dir"/slack_message.json | jq 'select(has("client_msg_id"))' > "$log_dir"/user_slack_message.json

user_slack_messages=$(cat "$log_dir"/user_slack_message.json)

if [ "$user_slack_messages" == "[]" ] || [ -z "$user_slack_messages" ]; then
  echo No slack messages found
  exit
fi

date=$(TZ=Asia/Tokyo date +'%Y-%m-%d')

github_title="いなうらゆうまはここにいた ${date}"

OWNER=YumaInaura \
REPOSITORY=playground \
  python "$api_dir"/github/issue.py > "$log_dir"/github-issue.json

cat "$log_dir"/github-issue.json | jq .

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

