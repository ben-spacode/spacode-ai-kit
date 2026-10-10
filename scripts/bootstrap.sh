#!/usr/bin/env bash
# One-line installer: clone the kit to a temp folder, install into a project, clean up.
#
# Usage (from anywhere):
#   bash bootstrap.sh <owner/repo-of-kit> <target-project-dir> [installer options...]
# Example:
#   bash bootstrap.sh spacode/spacode-ai-kit . --name "Demo CRM" --client "Acme" --mobile
set -euo pipefail

KIT_REPO="${1:-}"; TARGET="${2:-}"
[[ -z "$KIT_REPO" || -z "$TARGET" ]] && { echo "Usage: $0 <owner/repo> <target-dir> [--name N] [--client C] [--owner O] [--mobile] [--force]"; exit 1; }
shift 2

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "▶ Fetching $KIT_REPO"
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  gh repo clone "$KIT_REPO" "$TMP/kit" -- --depth 1 --quiet
else
  git clone --depth 1 --quiet "https://github.com/$KIT_REPO.git" "$TMP/kit"
fi

bash "$TMP/kit/scripts/install-spacode-kit.sh" "$TARGET" "$@"
