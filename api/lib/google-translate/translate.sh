#!/usr/bin/env bash

basedir=$(dirname "$0")

GOOGLE_APPLICATION_CREDENTIALS=~/.secret/google-service-credential.json gcloud auth application-default print-access-token

TOKEN=$("$basedir"/get-token.sh) python "$basedir"/translate.py
