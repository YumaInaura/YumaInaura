python timeline.py > log/timeline.json

cat log/timeline.json | jq --raw-output .id_str  | sed 's/^/https:\/\/twitter.com\/YumaInaura\/status\//g'

