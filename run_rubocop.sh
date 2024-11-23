#!/bin/bash

files=$(git status -s | cut -c4- | grep "\\.rb$")

echo 'Running Rubocop Linter'

for file in $files; do
  echo "Running linters on $file"
  bundle exec rubocop $file -A
done
