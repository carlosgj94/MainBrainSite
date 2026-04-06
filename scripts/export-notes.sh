#!/usr/bin/env bash
set -euo pipefail

VAULT_DIR="${1:-/home/juar/.openclaw/workspace/Main Brain}"
SITE_DIR="${2:-/home/juar/.openclaw/workspace/Main Brain Site}"

mkdir -p "$SITE_DIR/content/notes"

find "$VAULT_DIR/04 Publish/Ready" -maxdepth 1 -name '*.md' -type f -print0 | while IFS= read -r -d '' file; do
  cp "$file" "$SITE_DIR/content/notes/"
done

echo "Copied ready publish notes into Hugo content/notes/"
