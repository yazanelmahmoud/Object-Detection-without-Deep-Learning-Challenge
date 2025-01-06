#!/usr/bin/env bash
set -euo pipefail

# 1) Init orphan main
git init
git switch --orphan main

# 2) Verify Git identity
echo "Git user.name: $(git config --global user.name || echo '<not set>')"
echo "Git user.email: $(git config --global user.email || echo '<not set>')"
echo "Make sure the email is verified on GitHub."

# 3) Replay history (~60 commits)
bash scripts/replay_commits.sh scripts/milestones.csv
