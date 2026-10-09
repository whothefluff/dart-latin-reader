#!/usr/bin/env bash
# Checks that a built app packages the generated data.db and the current data_version.txt, and no CSVs.
# Usage: verify-bundled-database.sh <built app directory>
# Runs from the repository root, after the database was downloaded to build/generated_database.
set -eu

app="$1"
database="$(find "$app" -path '*/flutter_assets/assets/preprocessed_data/data.db' | head -n 1)"

if [ -z "$database" ] || ! cmp -s build/generated_database/data.db "$database"; then
  echo "::error::$app does not contain the generated database."
  exit 1
fi
if ! cmp -s assets/preprocessed_data/data_version.txt "$(dirname "$database")/data_version.txt"; then
  echo "::error::$app contains the wrong data version."
  exit 1
fi
if [ -n "$(find "$app" -iname '*.csv' | head -n 1)" ]; then
  echo "::error::$app still contains CSV files."
  exit 1
fi

echo "Verified database asset in $app; no CSV files packaged."
