---
name: release-promotion
description: Prepare a promotion from develop → staging or staging → main (production) — verify gates, compile changelog, list migrations and env changes, determine SemVer, write the PR and the release/rollback plan. Use when the user says "release", "promote to staging", "עולים לפרודקשן", "deploy to main", "תכין גרסה".
---

# Release Promotion

You prepare; the human merges and approves deploys.

## 1. Identify the promotion
`develop → staging` (release candidate) or `staging → main` (production). Hotfix? → see section 6.

## 2. Collect what's going out
```bash
git fetch --all --tags
git log --oneline origin/<target>..origin/<source>
git diff --stat origin/<target>..origin/<source>
git diff --name-only origin/<target>..origin/<source> | grep -E "migrations|schema.prisma|\.env\.example|workflows" 
```
- Group commits by type (feat/fix/perf/…); note breaking changes.
- Find migrations, new env vars (`.env.example` diff), new queues/workers, infra/workflow changes, Meta template changes.

## 3. Verify gates (report each as ✅/❌ with evidence)
- [ ] CI green on `<source>` head commit
- [ ] Full E2E green on the source environment (link to run)
- [ ] `main` is not ahead of `staging` / `staging` not ahead of `develop` (`git log origin/<source>..origin/<target>` is empty, except back-merged hotfixes)
- [ ] Migrations reviewed and ordered; backfills planned
- [ ] New env vars already set in the target environment
- [ ] For `staging → main`: `security-review` and `multi-tenant-guard` done; UAT/client sign-off if required
If any gate fails — stop and report; do not write the PR as ready.

## 4. Version & changelog
- SemVer: breaking → major, feat → minor, fix/perf only → patch.
- Update `CHANGELOG.md` (Keep a Changelog: Added / Changed / Fixed / Security / Removed) under the new version and date.

## 5. Promotion PR body
```
## Release vX.Y.Z  (<source> → <target>)
### Summary            (2–4 lines in Hebrew for the client/CTO)
### Changes            (from changelog)
### Migrations         (order, duration, rollback)
### Env / config       (new or changed variables, per environment)
### Infra              (new services, workers, scaling)
### Gates              (checklist with links)
### Rollback plan      (previous tag, steps, DB compatibility)
### Post-deploy checks (smoke list, dashboards to watch for 30 min)
```
After merge to `main`: tag `vX.Y.Z`, GitHub Release with the changelog section.

## 6. Hotfix
Branch `hotfix/<slug>` from `main` → PR to `main` (minimal change + test) → after release, PR `main → staging` and `staging → develop` the same day. Patch version bump.
