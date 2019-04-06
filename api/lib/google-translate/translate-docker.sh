#!/usr/bin/env bash

basedir=$(dirname "$0")

TOKEN=$(docker exec gcp /bin/bash ./get-token.sh) \
  python "$basedir"/translate.py | \
  jq -r '.data.translations[].translatedText'

