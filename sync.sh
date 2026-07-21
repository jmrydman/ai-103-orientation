#!/usr/bin/env bash
#
# sync.sh — copy the SINGLE whitelisted orientation note from the Obsidian vault
# into content/index.md (the site's one and only page).
#
# This site is fed by a PRIVATE study vault (mistake logs, scores, reflections),
# so unlike a purpose-built publishing vault this script never globs folders. It
# copies exactly ONE named file and refuses to run if that file isn't explicitly
# marked `visibility: public`. That single-file whitelist is the guardrail: no
# other note in the vault can ever reach content/.
#
# Usage:  ./sync.sh          (from the repo root)
#         VAULT="/path/to/vault" ./sync.sh   (override the vault location)
#
set -euo pipefail

VAULT="${VAULT:-$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/AI 103 Study}"
ROOT="$(cd "$(dirname "$0")" && pwd)"
CONTENT="$ROOT/content"
SRC="$VAULT/07 Resources/AI-103 Course Orientation.md"

if [ ! -e "$SRC" ]; then
  echo "ERROR: orientation note not found at:" >&2
  echo "  $SRC" >&2
  exit 1
fi

# Guard: only publish a note that opts in with `visibility: public`.
if ! grep -qE '^visibility:[[:space:]]*public[[:space:]]*$' "$SRC"; then
  echo "ERROR: '$SRC' is not marked 'visibility: public' — refusing to publish." >&2
  exit 1
fi

mkdir -p "$CONTENT"
cp "$SRC" "$CONTENT/index.md"
echo "synced 'AI-103 Course Orientation.md' -> content/index.md"
echo "OK. Now run: npx quartz build"
