#!/usr/bin/env bash

basedir=$(dirname "$0")

TOKEN=$(docker exec gcp /bin/bash ./get-token.sh) \
  eval "$basedir"/translate.py | \
  jq -r '.data.translations[].translatedText'

