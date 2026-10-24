#!/usr/bin/env bash
# dv-daily: answer one DV interview question, then commit + push.
# Usage: ./push.sh
set -e
cd "$(dirname "$0")"

TOTAL=$(wc -l < questions.tsv)
N=$(cat .next 2>/dev/null || echo 1)

if [ "$N" -gt "$TOTAL" ]; then
  echo "All $TOTAL questions done! Add more lines to questions.tsv (topic<TAB>question)."
  exit 0
fi

LINE=$(sed -n "${N}p" questions.tsv)
TOPIC=$(printf '%s' "$LINE" | cut -f1)
QUESTION=$(printf '%s' "$LINE" | cut -f2-)
ID=$(printf '%03d' "$N")
FILE="answers/$TOPIC/$ID.md"

mkdir -p "answers/$TOPIC"
if [ ! -f "$FILE" ]; then
  cat > "$FILE" <<EOF
# Q$ID - $TOPIC

**Question:** $QUESTION

**My answer:**

EOF
fi

echo ""
echo "Q$ID [$TOPIC]: $QUESTION"
echo "Write 3-5 lines below 'My answer', save and quit (:wq)."
sleep 1
${EDITOR:-vim} "$FILE"

# Do not commit an empty answer
ANSWER=$(sed -n '/\*\*My answer:\*\*/,$p' "$FILE" | tail -n +2 | grep -v '^[[:space:]]*$' || true)
if [ -z "$ANSWER" ]; then
  echo "No answer written, so nothing was committed. Run ./push.sh again when ready."
  exit 1
fi

echo $((N + 1)) > .next
echo "- $(date +%F) | Q$ID | $TOPIC | $QUESTION" >> PROGRESS.md

git add "$FILE" .next PROGRESS.md
git commit -q -m "Q$ID ($TOPIC): $(printf '%s' "$QUESTION" | cut -c1-60)"
git push -q
echo "Pushed Q$ID. Done for now!"
