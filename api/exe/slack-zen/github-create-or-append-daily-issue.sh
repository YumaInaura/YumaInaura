#!/usr/bin/env bash

set -eu

# --------------------------------------
# PREPAIR
# --------------------------------------

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"
source "${basedir}/prepare.sh"

set -x

slack_message="# test\nbody"
github_found_top_issue=$(cat "$github_found_issue_log_file")

if [[ ! -z '"$github_found_top_issue"' && '"$github_found_top_issue"' -ne "null" ]]; then
  title=$(echo "$github_found_top_issue" | jq --raw-output '.title')
  body=$(echo "$github_found_top_issue" | jq --raw-output '.body')$slack_message
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


