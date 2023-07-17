#!/usr/bin/env bash

set -eu

# Create a temporary file
temp_file=$(mktemp)

# Get text from default editor, or vim
${EDITOR:-vi} "$temp_file"

text=$(<"$temp_file")

if [ ! -z "$text" ] && [ "$text" != " " ]; then
  t update "$text"
  bsky post "$text"
  toot post "$text"
else
  echo "Aborted."
fi

# Clean up
rm "$temp_file"
