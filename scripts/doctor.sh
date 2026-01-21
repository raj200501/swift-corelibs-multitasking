#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

log() {
  echo "[doctor] $*"
}

if ! command -v swift >/dev/null 2>&1; then
  echo "[doctor] Swift not found. Install Swift 5.5+ and ensure 'swift' is on PATH." >&2
  exit 1
fi

log "Swift version"
swift --version

log "Git version"
if command -v git >/dev/null 2>&1; then
  git --version
else
  log "git not found (required for development workflows)"
fi

log "Repo status"
git status --short

log "Optional tooling"
if command -v swiftformat >/dev/null 2>&1; then
  log "swiftformat available"
else
  log "swiftformat not installed (format checks will be skipped)"
fi

if command -v swiftlint >/dev/null 2>&1; then
  log "swiftlint available"
else
  log "swiftlint not installed (lint checks will be skipped)"
fi
