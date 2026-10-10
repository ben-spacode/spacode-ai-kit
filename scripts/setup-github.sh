#!/usr/bin/env bash
# Spacode — set up a GitHub repo for the develop → staging → main flow.
# Requires: GitHub CLI (`gh auth login`) with admin rights on the repo.
#
# Usage: ./scripts/setup-github.sh <owner/repo> [--reviewer <github-username>]
#
# Creates: develop + staging branches, default branch = develop, branch protection on
# develop/staging/main, GitHub Environments development/staging/production
# (production requires reviewer approval).
# Note: branch protection on private repos requires a paid GitHub plan (Pro/Team) or an org plan that supports it.
set -euo pipefail

REPO="${1:-}"; [[ -z "$REPO" ]] && { echo "Usage: $0 <owner/repo> [--reviewer user]"; exit 1; }
shift || true
REVIEWER=""
while [[ $# -gt 0 ]]; do
  case "$1" in --reviewer) REVIEWER="$2"; shift 2 ;; *) echo "Unknown option $1"; exit 1 ;; esac
done
[[ -z "$REVIEWER" ]] && REVIEWER="$(gh api user -q .login)"

echo "▶ Configuring $REPO (reviewer: $REVIEWER)"

MAIN_SHA="$(gh api "repos/$REPO/git/ref/heads/main" -q .object.sha)"
for b in staging develop; do
  if gh api "repos/$REPO/git/ref/heads/$b" >/dev/null 2>&1; then
    echo "• branch $b exists"
  else
    gh api -X POST "repos/$REPO/git/refs" -f ref="refs/heads/$b" -f sha="$MAIN_SHA" >/dev/null
    echo "• created branch $b"
  fi
done

gh api -X PATCH "repos/$REPO" -f default_branch=develop \
  -F delete_branch_on_merge=true -F allow_squash_merge=true -F allow_merge_commit=true -F allow_rebase_merge=false >/dev/null
echo "• default branch = develop, auto-delete merged branches"

protect() { # branch approvals enforce_admins checks-json-array
  local branch="$1" approvals="$2" admins="$3" checks="$4"
  gh api -X PUT "repos/$REPO/branches/$branch/protection" --input - >/dev/null <<JSON
{
  "required_status_checks": { "strict": true, "contexts": $checks },
  "enforce_admins": $admins,
  "required_pull_request_reviews": { "required_approving_review_count": $approvals, "dismiss_stale_reviews": true, "require_code_owner_reviews": false },
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_linear_history": false,
  "required_conversation_resolution": true
}
JSON
  echo "• protected $branch (approvals=$approvals, enforce_admins=$admins)"
}
# Solo operator: 0 required approvals on develop so you can merge your own PRs after CI;
# staging/main enforced for admins too so nobody (including you or an AI agent) can push directly.
# Required checks: partial level into develop; full level (+ promotion gate) into staging and main.
protect develop 0 false '["partial"]'
protect staging 0 true  '["full-verify","full-e2e","full-nonfunctional","promotion-guard"]'
protect main    0 true  '["full-verify","full-e2e","full-nonfunctional","promotion-guard","release-load-test"]'

REVIEWER_ID="$(gh api "users/$REVIEWER" -q .id)"
for env in development staging production; do
  if [[ "$env" == "production" ]]; then
    gh api -X PUT "repos/$REPO/environments/$env" --input - >/dev/null <<JSON
{ "reviewers": [ { "type": "User", "id": $REVIEWER_ID } ],
  "deployment_branch_policy": { "protected_branches": false, "custom_branch_policies": true } }
JSON
    gh api -X POST "repos/$REPO/environments/$env/deployment-branch-policies" -f name=main >/dev/null 2>&1 || true
  else
    gh api -X PUT "repos/$REPO/environments/$env" >/dev/null
  fi
  echo "• environment $env"
done

cat <<EOF

✔ GitHub configured. Now add per-environment secrets/variables (Settings → Environments):
  variables: WEB_URL, API_URL, RAILWAY_SERVICES ("web engine worker agents"), LIGHTHOUSE_EXTRA_URLS (optional)
  secrets:   RAILWAY_TOKEN (Railway project token for that environment), E2E_USER, E2E_PASSWORD,
             EXPO_TOKEN (mobile projects), LHCI_GITHUB_APP_TOKEN (optional)
  Also: Settings → Code security → enable secret scanning + push protection, Dependabot alerts.
  Railway: turn OFF autodeploy on services deployed by pipeline.yml.
  Local machine: keep only develop (git switch develop && git branch -D main).
EOF
