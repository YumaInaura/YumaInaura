#!/usr/bin/env bash

base_dir=$(dirname "$0")

cat /dev/stdin \
  | redcarpet --parse=fenced_code_blocks \
  | FORMAT=html ./translate.sh \
  | jq . --raw-output \
  | reverse_markdown

