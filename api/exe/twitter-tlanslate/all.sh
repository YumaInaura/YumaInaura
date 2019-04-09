#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

"$basedir"/en-translate.sh*
"$basedir"/en-tweet.sh*
"$basedir"/ja-filter.sh*
"$basedir"/ja-timeline.sh*
