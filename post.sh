#!/usr/bin/env bash

set -eu

# Create a temporary file
temp_file=$(mktemp)

# Get text from default editor, or vim
${EDITOR:-vi} "$temp_file"

text=$(<"$temp_file")

if [ ! -z "$text" ] && [ "$text" != " " ]; then
  t update "$text"  || echo "failed to post: t"
  toot post "$text" || echo "failed to post: toot"
  bsky post "$text" || echo "failed to post: bsky"
else
  echo "Aborted."
fi

# Clean up
rm "$temp_file"
