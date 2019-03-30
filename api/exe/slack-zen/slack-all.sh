#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

basedir=$(dirname "$0")

"$basedir"/slack-message.sh
"$basedir"/format-message.sh

