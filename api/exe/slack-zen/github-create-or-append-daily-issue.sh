#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"
source "${basedir}/prepare.sh"

message=$(cat /dev/stdin)

if [ -z "$message" ]; then
  echo Nothing to do
fi

github_found_top_issue=$(cat "$github_found_top_issue_log_file")

if [[ ! -z "$github_found_top_issue" ]]; then
  body=$(echo "$github_found_top_issue" | jq --raw-output '.body')"$message"
  issue_number=$(echo "$github_found_top_issue" | jq '.["number"]')

  github_issue=$(
    USERNAME=YumaInaura \
    PASSWORD="$github_api_key" \
    REPOSITORY="$github_repository" \
    TITLE="$github_title" \
    BODY="$body" \
    NUMBER="$issue_number" \
    python "$api_dir"/github/create-or-edit-issue.py
  )
else
  body=$message

  github_issue=$(
    USERNAME=YumaInaura \
    PASSWORD="$github_api_key" \
    REPOSITORY="$github_repository" \
    TITLE="$github_title" \
    BODY="$body" \
    python "$api_dir"/github/create-or-edit-issue.py
  )
fi

echo "$github_issue"
