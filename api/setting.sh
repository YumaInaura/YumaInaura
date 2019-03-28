if [ $(uname -s) = "Darwin" ]; then
  date() { gdate $@; }
fi

python() { python3 $@; }

source ~/.secret/setting.sh

