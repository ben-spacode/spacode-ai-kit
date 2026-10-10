# Runbook — Deploy & Rollback

## Environments
| Env | Branch | URL (web) | URL (api) | Deploy | Approval |
|---|---|---|---|---|---|
| development | develop | https://dev.<domain> | https://api.dev.<domain> | auto after CI | — |
| staging | staging | https://staging.<domain> | https://api.staging.<domain> | auto after CI | — |
| production | main | https://<domain> | https://api.<domain> | GitHub Action | required reviewer |

## Normal release
1. Prepare promotion PR (skill: `release-promotion`).
2. Merge → pipeline builds, runs migrations (pre-deploy), deploys api/worker/web.
3. Smoke checks: login, main flow, `/health/ready`, queue processing, WhatsApp test message (non-prod).
4. Watch error tracker and dashboards for 30 minutes.
5. Tag `vX.Y.Z` and publish GitHub Release.

## Rollback
1. Revert the merge on GitHub (preferred) or redeploy the previous successful deployment of the affected Railway services; reconcile Git the same day.
2. If a migration ran: follow its rollback section in the release PR. Do not improvise on production DB.
3. Post a status update to the client; open an incident (skill: `incident-postmortem`).

## Contacts & access
| System | Owner | Admin access |
|---|---|---|
