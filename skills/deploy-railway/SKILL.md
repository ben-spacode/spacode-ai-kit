---
name: deploy-railway
description: Set up and operate a Spacode project on Railway, deployed only through GitHub — one service per component (web site+admin, landing, engine, worker, agents, postgres, redis) in three environments mapped to develop/staging/main, Wait-for-CI deploys, variables, domains, migrations, backups, rollback. Use for any Railway setup, deployment or deployment problem.
---

# Deploy on Railway (via GitHub)

Read `.cursor/rules/09-deployment-infra.mdc`. Verify current Railway features in Railway's docs when unsure.

## Setup checklist (human runs; you prepare values and config)
1. Railway project `<client>-<product>`; environments `development`, `staging`, `production`.
2. Services (each environment):
   | Service | Source | Start | Healthcheck |
   |---|---|---|---|
   | web | repo, root `apps/web` | `pnpm start` | `/api/health` |
   | landing (optional) | repo, root `apps/landing` | `pnpm start` | `/api/health` |
   | engine | repo, root `apps/engine` | per stack | `/health/ready` |
   | worker | same as engine | worker command | — |
   | agents | repo, root `apps/agents` | per stack | `/health/ready` |
   | postgres | Railway Postgres | — | — |
   | redis | Railway Redis | — | — |
   Use watch paths so a change in `apps/web` doesn't redeploy the engine.
3. Branch per environment: development ← `develop`, staging ← `staging`, production ← `main`.
4. **Deploy only after CI:** default is `.github/workflows/pipeline.yml` — Railway autodeploy OFF, a Railway project token per GitHub Environment (`RAILWAY_TOKEN`), `RAILWAY_SERVICES` variable listing services. Alternative: Railway GitHub integration with "Wait for CI" (see rule 09).
5. Variables per environment; reference variables for DB/Redis (`${{postgres.DATABASE_URL}}`, `${{redis.REDIS_URL}}`); private networking between services.
6. Pre-deploy command for migrations on `engine` (or `web` if no engine).
7. Domains + DNS; protect dev/staging; `noindex`.
8. Production Postgres backups on; monthly restore test into staging.
9. Usage alerts / spend limits; Sentry DSN per environment.
10. `railway.json` per service committed when using config-as-code.

## Deliverables
`docs/runbooks/deploy.md` (environment × service table, URLs, variable names only), `docs/runbooks/rollback.md`.

## Forbidden
`railway up` from a laptop to any environment, editing production variables without a PR/ticket, running migrations by hand.

## Rollback
Revert the merge on GitHub (preferred, keeps Git = truth) or redeploy the previous successful deployment in Railway, then reconcile Git the same day. Follow migration rollback notes.
