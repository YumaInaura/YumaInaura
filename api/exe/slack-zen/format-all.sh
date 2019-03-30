#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

basedir=$(dirname "$0")

"$basedir"/format-message.sh
"$basedir"/translate.sh

