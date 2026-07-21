#!/usr/bin/env bash
#
# publish.sh — one command to push your edits live.
#
# Edit the orientation note in the Obsidian vault (that's the source of truth):
#   "AI 103 Study/07 Resources/AI-103 Course Orientation.md"
# then run:
#     ./publish.sh                      # commits with a default message
#     ./publish.sh "reworded the intro" # commits with your message
#
# It runs sync.sh (vault -> content/index.md), commits, and pushes. GitHub
# Actions then builds and deploys the site — live in ~1-2 minutes. You do NOT
# need Node for this; the build happens on GitHub.
#
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"
export PATH="/opt/homebrew/bin:$PATH"   # make sure git is found

MSG="${1:-Update content}"

echo "1/3  Syncing vault -> content/ ..."
./sync.sh

if git diff --quiet && git diff --cached --quiet; then
  echo ""
  echo "Nothing changed — your vault edit didn't alter the published page."
  echo "(Did you save the note in Obsidian? Is it still marked visibility: public?)"
  exit 0
fi

echo ""
echo "2/3  Committing: \"$MSG\""
git add -A
git commit -q -m "$MSG"

echo "3/3  Pushing to GitHub ..."
git push -q

echo ""
echo "✓ Published. GitHub is building + deploying now."
echo "  Live in ~1-2 min:  https://jmrydman.github.io/ai-103-orientation"
