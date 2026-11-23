#!/bin/bash
# tools/promote against a local repository standing in for a team's fork.
set -euo pipefail
here=$(cd "$(dirname "$0")/.." && pwd)
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
export GIT_AUTHOR_NAME=Ann GIT_AUTHOR_EMAIL=ann@example.org GIT_COMMITTER_NAME=Ann GIT_COMMITTER_EMAIL=ann@example.org

git init -q "$tmp/fork" && cd "$tmp/fork"
mkdir -p day2/simulation day2/reconstruction
echo sim > day2/simulation/sim.py
echo rec > day2/reconstruction/rec.py
git add -A && git commit -qm "Day 2"
voted=$(git rev-parse HEAD)
echo sim2 > day2/simulation/sim.py; git commit -qam "Edited after the vote"

git init -q "$tmp/repo" && cd "$tmp/repo"
mkdir -p stages/simulation pipeline && touch stages/simulation/README.md pipeline/README.md
cp "$here/tools/promote" . 2>/dev/null; mkdir tools && mv promote tools/
git add -A && git commit -qm init && git branch -M main

fails() { if "$@" >/dev/null 2>&1; then echo "should have failed: $*"; exit 1; fi; }
fails tools/promote simulation "$tmp/fork" "$voted" day2/simulation   # on main
git checkout -q -b winners
fails tools/promote nonsense "$tmp/fork" "$voted" day2/simulation     # unknown stage
fails tools/promote simulation "$tmp/fork" "$voted" day9/simulation   # no such folder
tools/promote simulation "$tmp/fork" "$voted" day2/simulation/ >/dev/null

[ "$(cat pipeline/simulation/sim.py)" = sim ] || { echo "not the voted commit"; exit 1; }
[ ! -e pipeline/simulation/rec.py ] || { echo "copied another stage"; exit 1; }
grep -q "$voted" pipeline/simulation/SOURCE.md
git log -1 --format=%B | grep -q "Co-authored-by: Ann <ann@example.org>"
[ -z "$(git status --porcelain)" ]
tools/promote simulation "$tmp/fork" "$voted" day2/simulation >/dev/null   # again: replaces
echo ok
