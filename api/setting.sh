shopt -s expand_aliases

if [ $(uname -s) = "Darwin" ]; then
  alias date=gdate
fi

alias python=python3

source ~/.secret/setting.sh

