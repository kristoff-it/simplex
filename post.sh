#!/bin/sh

set -eu

t update $1
bsky post $1
toot post $1

