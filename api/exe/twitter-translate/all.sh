#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

eval "$basedir"/ja-timeline.sh
eval "$basedir"/filter-recent.sh
eval "$basedir"/en-translate.sh
eval "$basedir"/en-seed.sh
eval "$basedir"/en-tweet.sh

