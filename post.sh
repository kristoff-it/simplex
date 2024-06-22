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
if [ "$#" -gt 0 ]; then
  twitter_imgs=()
  for file in "$@"; do
    twitter_imgs+=("--file" "$file")
  done
  
  t update "$text"  "${twitter_imgs[@]}" || echo "failed to post: t"
else
  t update "$text" || echo "failed to post: t"
fi

# Mastodon
if [ "$#" -gt 0 ]; then
  mastodon_imgs=()
  for file in "$@"; do
    mastodon_imgs+=("-m" "$file")
  done

  toot post "$text" "${mastodon_imgs[@]}" || echo "failed to post: toot"
else
  toot post "$text" || echo "failed to post: toot"
fi

# Bluesky
if [ "$#" -gt 0 ]; then
  bluesky_imgs=()
  for file in "$@"; do
    bluesky_imgs+=("--image" "$file")
  done

  bsky post "${bluesky_imgs[@]}" "$text" || echo "failed to post: bsky"
else
  bsky post "$text" || echo "failed to post: bsky"
fi


if [ "$#" -gt 0 ]; then
  echo "Skipping LinkedIn as it doesn't support images."
else
  linkedin post -v public "$text" || echo "failed to post: linkedin"
fi

# Clean up
rm "$temp_file"
