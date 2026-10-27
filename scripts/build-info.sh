#!/usr/bin/env bash

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

VERSION="$(git -C "$repo_root" describe --tags --always --dirty)"
COMMIT_HASH="$(git -C "$repo_root" rev-parse --short HEAD)"
BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"

printf 'VERSION=%s\nCOMMIT_HASH=%s\nBUILD_DATE=%s\n' \
  "$VERSION" "$COMMIT_HASH" "$BUILD_DATE" > "$repo_root/build.txt"

printf 'Wrote build metadata to %s\n' "$repo_root/build.txt"
