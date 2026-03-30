#!/usr/bin/env bash

set -euo pipefail

search_root="${1:-$HOME/code}"

if [[ ! -d "$search_root" ]]; then
  printf 'Error: directory not found: %s\n' "$search_root" >&2
  exit 1
fi

find "$search_root" \
  \( -type d -name .git -prune -print -o -type f -name .git -print \) 2>/dev/null \
  | while IFS= read -r git_path; do
      dirname "$git_path"
    done \
  | sort -u
