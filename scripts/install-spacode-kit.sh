#!/usr/bin/env bash
# Spacode AI Kit — install rules, skills, docs, tests, workflows and MCP config into a project.
#
# Usage:
#   ./scripts/install-spacode-kit.sh <target-project-dir> [--name "Project"] [--client "Client"] [--owner github-user] [--mobile] [--force]
#
#   --mobile   also install the EAS workflow and Expo templates (projects with an Expo app)
#   --force    overwrite project files that already exist (rules and skills are always refreshed)
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-}"
[[ -z "$TARGET" || "$TARGET" == --* ]] && { echo "Usage: $0 <target-dir> [--name N] [--client C] [--owner O] [--mobile] [--force]"; exit 1; }
shift

PROJECT_NAME="" CLIENT_NAME="" GITHUB_OWNER="" FORCE=0 MOBILE=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --name)   PROJECT_NAME="$2"; shift 2 ;;
    --client) CLIENT_NAME="$2"; shift 2 ;;
    --owner)  GITHUB_OWNER="$2"; shift 2 ;;
    --mobile) MOBILE=1; shift ;;
    --force)  FORCE=1; shift ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

mkdir -p "$TARGET"
TARGET="$(cd "$TARGET" && pwd)"
[[ -z "$PROJECT_NAME" ]] && PROJECT_NAME="$(basename "$TARGET")"
KIT_VERSION="$(cat "$KIT_DIR/VERSION" 2>/dev/null || echo dev)"
T="$KIT_DIR/templates"

copy_file() { # src dst
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" && $FORCE -eq 0 ]]; then
    echo "  skip (exists)  ${dst#$TARGET/}"
  else
    cp "$src" "$dst"; echo "  write          ${dst#$TARGET/}"
  fi
}

echo "▶ Installing Spacode AI Kit v$KIT_VERSION into $TARGET"

echo "• Cursor rules → .cursor/rules/ (refreshed)"
mkdir -p "$TARGET/.cursor/rules"
cp "$KIT_DIR"/rules/*.mdc "$TARGET/.cursor/rules/"

echo "• Skills → .cursor/skills/ and .claude/skills/ (refreshed)"
for dir in .cursor/skills .claude/skills; do
  mkdir -p "$TARGET/$dir"
  for skill in "$KIT_DIR"/skills/*/; do
    name="$(basename "$skill")"
    rm -rf "$TARGET/$dir/$name"
    cp -R "$skill" "$TARGET/$dir/$name"
  done
done

echo "• Cursor MCP (Stitch) → .cursor/mcp.json"
copy_file "$T/cursor/mcp.json" "$TARGET/.cursor/mcp.json"

echo "• Agent manuals"
copy_file "$T/AGENTS.md"    "$TARGET/AGENTS.md"
copy_file "$T/CLAUDE.md"    "$TARGET/CLAUDE.md"
copy_file "$T/CHANGELOG.md" "$TARGET/CHANGELOG.md"

echo "• Docs → docs/"
mkdir -p "$TARGET"/docs/{prd,erd,adr,runbooks,postmortems,handoff,maintenance,design,brand,testing,marketing,product,business/reports,templates}
for d in prd postmortems handoff maintenance; do touch "$TARGET/docs/$d/.gitkeep"; done
# Reference templates (always available for new documents)
for f in "$T"/docs/*; do copy_file "$f" "$TARGET/docs/templates/$(basename "$f")"; done
mkdir -p "$TARGET/docs/templates/nextjs-seo" "$TARGET/docs/templates/mobile"
for f in "$T"/nextjs-seo/*; do copy_file "$f" "$TARGET/docs/templates/nextjs-seo/$(basename "$f")"; done
for f in "$T"/mobile/*;     do copy_file "$f" "$TARGET/docs/templates/mobile/$(basename "$f")"; done
# Working copies at their final locations
copy_file "$T/docs/PROJECT-STATUS.md"            "$TARGET/docs/PROJECT-STATUS.md"
copy_file "$T/docs/ERD.md"                       "$TARGET/docs/erd/ERD.md"
copy_file "$T/docs/ADR-0001-stack-and-hosting.md" "$TARGET/docs/adr/ADR-0001-stack-and-hosting.md"
copy_file "$T/docs/RUNBOOK-deploy.md"            "$TARGET/docs/runbooks/deploy.md"
copy_file "$T/docs/DESIGN-BRIEF.md"              "$TARGET/docs/design/DESIGN-BRIEF.md"
copy_file "$T/docs/BRAND-GUIDE.md"               "$TARGET/docs/brand/BRAND-GUIDE.md"
copy_file "$T/docs/TEST-PLAN.md"                 "$TARGET/docs/testing/TEST-PLAN.md"
copy_file "$T/docs/PAID-ADS-APPENDIX.md"         "$TARGET/docs/marketing/PAID-ADS-APPENDIX.md"
copy_file "$T/docs/CONTENT-PLAN.md"              "$TARGET/docs/marketing/CONTENT-PLAN.md"
copy_file "$T/docs/keyword-map.csv"              "$TARGET/docs/marketing/keyword-map.csv"
copy_file "$T/docs/POC.md"                       "$TARGET/docs/product/POC.md"
copy_file "$T/docs/MVP.md"                       "$TARGET/docs/product/MVP.md"
copy_file "$T/docs/BUSINESS-MODEL.md"            "$TARGET/docs/business/BUSINESS-MODEL.md"
copy_file "$T/docs/FORECAST.md"                  "$TARGET/docs/business/FORECAST.md"
copy_file "$T/docs/INVESTOR-DECK.md"             "$TARGET/docs/business/INVESTOR-DECK.md"
copy_file "$T/docs/KPI-CATALOG.md"               "$TARGET/docs/business/reports/KPI-CATALOG.md"
copy_file "$T/docs/QUARTERLY-REPORT.md"          "$TARGET/docs/business/reports/QUARTERLY-REPORT.md"
copy_file "$T/docs/ANNUAL-REPORT.md"             "$TARGET/docs/business/reports/ANNUAL-REPORT.md"

echo "• GitHub → .github/"
( cd "$T/github" && find . -type f ) | while read -r f; do
  rel="${f#./}"
  [[ "$rel" == "workflows/eas.yml" && $MOBILE -eq 0 ]] && continue
  copy_file "$T/github/$rel" "$TARGET/.github/$rel"
done

echo "• Root config, tests, quality tools"
( cd "$T/root" && find . -type f ) | while read -r f; do
  rel="${f#./}"
  copy_file "$T/root/$rel" "$TARGET/$rel"
done

if [[ $MOBILE -eq 1 && -d "$TARGET/apps/mobile" ]]; then
  echo "• Mobile templates → apps/mobile/"
  copy_file "$T/mobile/eas.json"      "$TARGET/apps/mobile/eas.json"
  copy_file "$T/mobile/app.config.ts" "$TARGET/apps/mobile/app.config.ts"
fi

echo "• Filling placeholders"
sub() { # file placeholder value — only substitutes when a value was given
  local f="$1" key="$2" val="$3"
  [[ -f "$f" && -n "$val" ]] || return 0
  local esc="${val//\\/\\\\}"; esc="${esc//|/\\|}"; esc="${esc//&/\\&}"
  sed -i.bak "s|{{${key}}}|${esc}|g" "$f" && rm -f "$f.bak"
}
while IFS= read -r -d '' f; do
  sub "$f" PROJECT_NAME "$PROJECT_NAME"
  sub "$f" CLIENT_NAME  "$CLIENT_NAME"
  sub "$f" GITHUB_OWNER "$GITHUB_OWNER"
done < <(find "$TARGET/AGENTS.md" "$TARGET/.github/CODEOWNERS" "$TARGET/docs" -type f \( -name '*.md' -o -name 'CODEOWNERS' \) -not -path '*/docs/templates/*' -print0 2>/dev/null)

echo "$KIT_VERSION" > "$TARGET/.cursor/.spacode-kit-version"

cat <<EOF

✔ Done. Next steps:
  1. Fill the remaining {{placeholders}} in AGENTS.md (description, project type, domains, AI provider).
  2. Set STITCH_API_KEY in your OS/shell environment (not in the repo) and check Cursor Settings → MCP shows "stitch".
  3. git add -A && git commit -m "chore: apply spacode ai kit v$KIT_VERSION"
  4. Run scripts/setup-github.sh <owner/repo> from the kit (branches, required checks, environments).
  5. Locally keep only develop:  git switch develop && git branch -D main
  6. In Cursor / Claude:  "run the project-kickoff skill"
EOF
