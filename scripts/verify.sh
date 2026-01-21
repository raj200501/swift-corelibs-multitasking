#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

log() {
  echo "[verify] $*"
}

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "[verify] Missing required command: $1" >&2
    exit 1
  fi
}

run_optional() {
  local label="$1"
  shift
  if command -v "$1" >/dev/null 2>&1; then
    log "$label"
    "$@"
  else
    log "Skipping $label (missing $1)"
  fi
}

require_cmd swift

run_optional "format check" swiftformat --lint Sources tests
run_optional "lint" swiftlint lint --quiet

log "typecheck (swift build)"
swift build

log "unit tests"
swift test

log "build (release)"
swift build -c release

log "smoke test (demo)"
swift run multitasking-demo
