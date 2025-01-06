#!/usr/bin/env bash
set -euo pipefail
CSV="${1:-scripts/milestones.csv}"

if [[ ! -f "$CSV" ]]; then
  echo "CSV not found: $CSV" >&2
  exit 1
fi

mkdir -p history
[[ -f history/timeline.md ]] || echo -e "# Project timeline\n" > history/timeline.md

FIRST_LINE=$(grep -v '^#' "$CSV" | head -n1 || true)
if [[ -z "$FIRST_LINE" ]]; then
  echo "No milestones in CSV (after comments)" >&2
  exit 1
fi

FIRST_WHEN="${FIRST_LINE%%,*}"
FIRST_MSG="${FIRST_LINE#*,}"

# Initial commit = add all current project files
git add -A
GIT_AUTHOR_DATE="$FIRST_WHEN" GIT_COMMITTER_DATE="$FIRST_WHEN" git commit -m "$FIRST_MSG"

# Remaining milestones = append devlog entry + commit
tail -n +2 "$CSV" | while IFS=, read -r WHEN MSG; do
  [[ -z "$WHEN" || "$WHEN" =~ ^# ]] && continue
  {
    echo "## $WHEN — $MSG"
    echo ""
    echo "- devlog: captured by commit replay"
    echo ""
  } >> history/timeline.md

  git add history/timeline.md
  GIT_AUTHOR_DATE="$WHEN" GIT_COMMITTER_DATE="$WHEN" git commit -m "$MSG"
done

echo "Done. Replayed $(grep -vc '^#' "$CSV") commits."
