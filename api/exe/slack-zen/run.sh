#!/usr/bin/env bash

set -eu

# --------------------------------------
# PREPAIR
# --------------------------------------

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"

api_dir="${basedir}/../../lib"
log_dir="${basedir}"/log

mkdir -p "${log_dir}"

date=$(TZ=Asia/Tokyo date +'%Y-%m-%d')
github_title="いなうらゆうまはここにいた ${date}"


github_repository="playground"

# --------------------------------------

eval "${basedir}/channel-history.sh" > "$log_dir"/channel-message.json

cat "$log_dir"/channel-message.json | jq '.["messages"][]' > "$log_dir"/slack-message.json
cat "$log_dir"/slack-message.json | jq 'select(has("client_msg_id"))' > "$log_dir"/user-slack-message.json

user_slack_messages=$(cat "$log_dir"/user-slack-message.json)

if [ "$user_slack_messages" == "[]" ] || [ -z "$user_slack_messages" ]; then
  echo No slack messages found
  exit
fi

OWNER=YumaInaura \
REPOSITORY=playground \
  python "$api_dir"/github/issue.py \
    > "$log_dir"/github-issue.json

cat "$log_dir"/github-issue.json | \
  jq -c 'select(.["title"] | contains("'"$github_title"'"))' \
  > "$log_dir"/github-found-issue.json

found_top_issue=$(cat "$log_dir"/github-found-issue.json | head -n 1)

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

