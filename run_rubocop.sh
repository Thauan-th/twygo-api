#!/bin/bash

files=$(git status -s | cut -c4- | grep "\\.rb$")

echo 'Running Rubocop Linter'

not_ok=()

for file in $files; do
  echo "Running linters on $file"

  if ! bundle exec rubocop $file -A; then
    not_ok+=($file)
  fi
done

if [ ${#not_ok[@]} -eq 0 ]; then
  echo 'Rubocop Linter passed'
  exit 0
else
  echo 'Some files are not passing Rubocop Linter:'
  for file in "${not_ok[@]}"; do
    echo "  - $file"
  done
  exit 1
fi