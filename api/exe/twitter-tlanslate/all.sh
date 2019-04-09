#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

"$basedir"/ja-timeline.sh
"$basedir"/filter-recent.sh
"$basedir"/en-translate.sh
"$basedir"/en-tweet.sh

