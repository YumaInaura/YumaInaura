#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

"$basedir"/slack-all.sh && \
"$basedir"/translate-all.sh && \
"$basedir"/github-all.sh

