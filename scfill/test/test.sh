#!/usr/bin/env bash -eu

readonly file_path=$(basename "$0")
readonly current_dir=$(echo "$0" | sed -e "s/\/${file_path}$//g")

readonly fixture_script_path="${current_dir}/../fixtures/script.sh"

echo "=============================="
echo "Input"
echo "------------------------------"
cat "$fixture_script_path"

echo "=============================="
echo "Expected"
echo "------------------------------"
readonly expected=$(cat <<'EOM'
#!/usr/bin/env bash -eu

echo Alice
# Alice

echo Bob && echo Carol 
# Bob
# Carol

echo -e "David\nEric"
# David
# Eric
EOM
)
echo "$expected"

echo "=============================="
echo "Got"
echo "------------------------------"
eval "${current_dir}/../bin/scfill" "$fixture_script_path"

