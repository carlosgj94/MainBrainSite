#!/usr/bin/env bash
set -euo pipefail

VAULT_DIR="${1:-/home/juar/.openclaw/workspace/Main Brain}"
SITE_DIR="${2:-/home/juar/.openclaw/workspace/Main Brain Site}"
SRC_DIR="$VAULT_DIR/04 Publish/Ready"
DST_DIR="$SITE_DIR/content/notes"

mkdir -p "$DST_DIR"

convert_note() {
  local src="$1"
  local base out slug title summary created updated tags topics body started_body=0 in_summary=0 in_body=0
  base="$(basename "$src")"
  out="$DST_DIR/$base"

  slug="$(awk -F': ' '/^slug:/ {gsub(/"/, "", $2); print $2; exit}' "$src")"
  title="$(awk 'BEGIN{seen=0} /^# /{sub(/^# /, ""); print; exit}' "$src")"
  summary="$(awk 'BEGIN{flag=0} /^## Summary/{flag=1; next} /^## Body/{flag=0} flag{ if(length($0)>0){sub(/^- /, "", $0); print; exit}}' "$src")"
  created="$(awk -F': ' '/^created:/ {print $2; exit}' "$src")"
  updated="$(awk -F': ' '/^updated:/ {print $2; exit}' "$src")"
  tags="$(awk -F': ' '/^tags:/ {print $2; exit}' "$src")"
  topics="$(awk -F': ' '/^topics:/ {print $2; exit}' "$src")"

  body="$(awk 'BEGIN{flag=0} /^## Body/{flag=1; next} flag{print}' "$src")"

  cat > "$out" <<EOF
---
title: ${title}
slug: ${slug}
summary: ${summary}
date: ${created}
updated: ${updated}
tags: ${tags}
topics: ${topics}
---

${body}
EOF
}

find "$SRC_DIR" -maxdepth 1 -name '*.md' -type f -print0 | while IFS= read -r -d '' file; do
  convert_note "$file"
done

echo "Exported ready publish notes into Hugo content/notes/"
