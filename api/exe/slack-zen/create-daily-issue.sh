#!/usr/bin/env bash

set -eu

# --------------------------------------
# PREPAIR
# --------------------------------------

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"

api_dir="${basedir}/../../lib"
log_dir="${basedir}"/log

date=$(TZ=Asia/Tokyo date +'%Y-%m-%d')
github_title="いなうらゆうまはここにいた ${date}"

github_repository="playground"

github_found_issue_log_file="$log_dir"github-found-issue.json
github_found_issue=(cat "$github_found_issue_log_file")

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
    python "$api_dir"/github/create-or-edit-issue.py
  )
fi


#pushd "$api_dir"
  # echo "$slack_message" | python ./twitter/oneline-split.py | ./twitter/create.sh 
#popd

