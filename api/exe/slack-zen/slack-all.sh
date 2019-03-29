#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")

"$basedir"/slack-message.sh && \
  "$basedir"/format-message.sh

