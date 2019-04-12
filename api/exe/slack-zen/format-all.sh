#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

base_dir=$(dirname "$0")

"$base_dir"/format-message.sh
"$base_dir"/translate.sh

