basedir=$(dirname "$0")

default_setting_file="$basedir"/zen-setting.sh
setting_file=${SETTING_FILE:-$default_setting_file}

source "$setting_file"
