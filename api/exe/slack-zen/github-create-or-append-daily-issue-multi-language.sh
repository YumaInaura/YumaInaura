#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

basedir=$(dirname "$0")
source "${basedir}/prepare.sh"

cat "$markdown_text_log_file" | "${basedir}"/github-create-or-append-daily-issue.sh

