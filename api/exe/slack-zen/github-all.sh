#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")

"$basedir"/github-issue-list.sh && \
"$basedir"/github-filter-issue.sh && \
"$basedir"/github-create-or-append-daily-issue.sh

