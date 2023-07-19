#!/usr/bin/env bash

set -eu

# Max 4 img arguments

if [ "$#" -gt 4 ]; then
  echo "Max 4 images per message."
  exit 1
fi

# Create a temporary file
temp_file=$(mktemp)

# Get text from default editor, or vim
${EDITOR:-vi} "$temp_file"

text=$(<"$temp_file")

if [ -z "$text" ] || [ "$text" == " " ]; then
  echo "Aborted."
  exit 1
fi

# Twitter
twitter_imgs=()
for file in "$@"; do
  twitter_imgs+=("--file" "$file")
done

t update "$text"  "${twitter_imgs[@]}" || echo "failed to post: t"

# Mastodon and Bluesky
other_imgs=()
for file in "$@"; do
  other_imgs+=("--image" "$file")
done

toot post "$text" "${other_imgs[@]}" || echo "failed to post: toot"
bsky post "$text" "${other_imgs[@]}" || echo "failed to post: bsky"

# Clean up
rm "$temp_file"
