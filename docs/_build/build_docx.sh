#!/usr/bin/env bash
# Build customer-handoff DOCX from markdown sources.
# Requires: pandoc
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT="${ROOT}/docs/_build/out"
mkdir -p "$OUT"

REFERENCE="${ROOT}/docs/_build/reference.docx"

build_one() {
  local src="$1"
  local base
  base="$(basename "$src" .md)"
  local dst="${OUT}/${base}.docx"
  echo "Building ${dst}..."
  if [[ -f "$REFERENCE" ]]; then
    pandoc "$src" -o "$dst" --reference-doc="$REFERENCE"
  else
    pandoc "$src" -o "$dst"
  fi
}

# Main guide assembly (README + all phases)
build_one "${ROOT}/README.md"
build_one "${ROOT}/docs/01-epic-architecture-tiers.md"
build_one "${ROOT}/validation/01-pov-test-plan.md"

echo "Done. Output in ${OUT}/"
