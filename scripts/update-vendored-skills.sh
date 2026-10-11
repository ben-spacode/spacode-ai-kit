#!/usr/bin/env bash
# Refresh external (vendored) skills from their source repositories and re-apply the Spacode adapters.
#
# Usage: ./scripts/update-vendored-skills.sh [--from-dir <dir-with-clones>]
#   --from-dir  use existing clones named after the source keys in vendor/skills.json (offline / testing)
#
# Reads vendor/skills.json. For each skill: copies <source>/<path> into skills/<name> (minus "exclude"),
# inserts vendor/adapters/<name>.md right after the YAML frontmatter, and writes the source LICENSE next to it.
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MANIFEST="$KIT_DIR/vendor/skills.json"
FROM_DIR=""
[[ "${1:-}" == "--from-dir" ]] && FROM_DIR="$2"
command -v jq >/dev/null || { echo "jq is required"; exit 1; }

TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT

for src in $(jq -r '.sources | keys[]' "$MANIFEST"); do
  if [[ -n "$FROM_DIR" ]]; then
    ln -s "$(cd "$FROM_DIR/$src" && pwd)" "$TMP/$src"
  else
    repo="$(jq -r --arg s "$src" '.sources[$s].repo' "$MANIFEST")"
    echo "▶ cloning $repo"
    git clone -q --depth 1 "$repo" "$TMP/$src"
  fi
  (cd "$TMP/$src" && git rev-parse --short HEAD 2>/dev/null || echo unknown) > "$TMP/$src.rev"
done

count=$(jq '.skills | length' "$MANIFEST")
for i in $(seq 0 $((count - 1))); do
  name="$(jq -r ".skills[$i].name" "$MANIFEST")"
  src="$(jq -r ".skills[$i].source" "$MANIFEST")"
  path="$(jq -r ".skills[$i].path" "$MANIFEST")"
  dest="$KIT_DIR/skills/$name"
  [[ -f "$TMP/$src/$path/SKILL.md" ]] || { echo "✗ $src/$path/SKILL.md not found"; exit 1; }

  rm -rf "$dest"; mkdir -p "$dest"
  cp -R "$TMP/$src/$path/." "$dest/"
  for ex in $(jq -r ".skills[$i].exclude[]?" "$MANIFEST"); do rm -rf "${dest:?}/$ex"; done

  # Insert adapter after the closing '---' of the frontmatter
  adapter="$KIT_DIR/vendor/adapters/$name.md"
  if [[ -f "$adapter" ]]; then
    awk -v adapter="$adapter" '
      BEGIN { fm=0; done=0 }
      { print }
      /^---[[:space:]]*$/ { fm++; if (fm==2 && !done) { print ""; while ((getline line < adapter) > 0) print line; print ""; done=1 } }
    ' "$dest/SKILL.md" > "$dest/SKILL.md.tmp" && mv "$dest/SKILL.md.tmp" "$dest/SKILL.md"
  fi

  cp "$TMP/$src/LICENSE" "$dest/LICENSE" 2>/dev/null || true
  printf 'Vendored from %s (%s) at commit %s. License: %s. Spacode adapter: vendor/adapters/%s.md\n' \
    "$(jq -r --arg s "$src" '.sources[$s].repo' "$MANIFEST")" "$path" "$(cat "$TMP/$src.rev")" \
    "$(jq -r --arg s "$src" '.sources[$s].license' "$MANIFEST")" "$name" > "$dest/SOURCE.txt"
  echo "✔ $name ← $src/$path"
done
echo "Done. Review with: git diff --stat skills/"
