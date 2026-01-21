#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

log() {
  echo "[lint] $*"
}

if command -v swiftformat >/dev/null 2>&1; then
  log "swiftformat --lint"
  swiftformat --lint Sources tests
else
  log "swiftformat not installed; skipping"
fi

if command -v swiftlint >/dev/null 2>&1; then
  log "swiftlint lint"
  swiftlint lint --quiet
else
  log "swiftlint not installed; skipping"
fi
