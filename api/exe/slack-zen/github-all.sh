#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")

"$basedir"/github-issue-list.sh && \
"$base_dir"/github-filter-issue.sh && \
"${base_dir}"/github-create-or-append-daily-issue.sh

