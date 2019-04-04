source ~/.secret/setting.sh

if [ $(uname -s) = "Darwin" ]; then
  alias date=gdate
  alias sed=gsed
fi

alias python=python3

basedir=$(dirname "$0")


