#!/usr/bin/env bash

basedir=$(dirname "$0")

cat /dev/stdin \
  | redcarpet --parse=fenced_code_blocks \
  | FORMAT=html ./translate.sh \
  | jq . --raw-output \
  | reverse_markdown

