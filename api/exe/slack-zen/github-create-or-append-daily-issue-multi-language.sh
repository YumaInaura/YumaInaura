#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

base_dir=$(dirname "$0")
source "${base_dir}/prepare.sh"

cat "$markdown_text_log_file" | \
  TITLE="$ja_github_title" \
  "${base_dir}"/github-create-or-append-daily-issue.sh

cat "$google_translate_en_log_file" | \
  TITLE="$en_github_title" \
  "${base_dir}"/github-create-or-append-daily-issue.sh

