#!/usr/bin/env bash

export LC_CTYPE=en_US.UTF-8

function python() {
  /usr/bin/python3.4 $@
}

cd /api/YumaInaura

pushd ./twitter
  python timeline.py > log/timeline.log
  cat log/timeline.log | python jst-datetime-filter.py > log/timeline-jst-yesterday.log
  cat log/timeline-jst-yesterday.log | python markdown.py > log/markdown.log
popd

date=$(TZ=JST date --date="1 days ago" +'%Y-%m-%d')

export USERNAME=YumaInaura \
  REPOSITORY=YumaInaura \
  PASSWORD=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \
  TITLE="いなうらゆうま はここにいた ${date} on Twitter" \
  FILE=./twitter/log/markdown.log \
  LABELS=medium,hatena,japanese

python github/create-issue.py
