# AGENTS.md — {{PROJECT_NAME}}

> Operating manual for AI agents (Cursor, Claude Code, Claude) working in this repository.
> Full rules: `.cursor/rules/*.mdc`. Skills: `.cursor/skills/` and `.claude/skills/`.

## Project
- **Name:** {{PROJECT_NAME}}
- **Client:** {{CLIENT_NAME}}
- **Owner / CTO:** Spacode — Ben Efraimov
- **What it does:** {{ONE_LINE_DESCRIPTION}}
- **Project type:** {{website+admin | landing page | mobile app | combination}}
- **Hosting:** Railway, deployed only through GitHub — see `docs/adr/ADR-0001-stack-and-hosting.md`
- **Domains:** dev: {{dev.domain}} · staging: {{staging.domain}} · prod: {{domain}}
- **AI provider (agents):** {{Claude API | OpenAI API}}

## Stack
- `apps/web` — Next.js: website `app/(site)` + admin `app/(admin)` in one project
- `apps/engine` — server engine: {{NestJS | FastAPI}} (if needed)
- `apps/worker` — queue processors · `apps/agents` — AI agents service (customer-service agent + future agents)
- `apps/mobile` — Expo + EAS (if a mobile app)
- PostgreSQL · Redis · TypeScript strict / Python typed · Hebrew RTL first
- Railway services: web · landing · engine · worker · agents · postgres · redis

## Commands
```bash
pnpm install            # install
docker compose up -d    # local Postgres + Redis
pnpm dev                # run all apps
pnpm lint && pnpm typecheck && pnpm test       # partial level
pnpm test:e2e           # Playwright (full level)
pnpm db:migrate:dev     # create/apply migration locally ONLY
```

## Non-negotiables (summary)
1. Locally only `develop` + work branches from it. Flow: work branch → `develop` → `staging` → `main`. Never push/merge to `staging`/`main` yourself.
2. Partial tests before `develop`; full functional + non-functional tests from `develop` up. Red check = no merge.
3. Railway is updated only by GitHub merges — never deploy from a laptop.
4. Vet every dependency/version for vulnerabilities before adding it.
5. PRD → ERD → ADR → design (Stitch MCP) → skeleton → code. Plan first for > 3 files or DB/infra.
6. Every tenant-owned query is scoped by `tenant_id`; test cross-tenant access.
7. No secrets, PII or customer data in code, logs, prompts or commits.
8. Public pages: SEO foundation, pixels readiness, Lighthouse ≥ 90, IS 5568 accessibility.
9. Hebrew/RTL: logical CSS, strings in `messages/he.json`, `Asia/Jerusalem` display, UTC storage.
10. Conventional Commits in English.

## Where things are
- `docs/prd` · `docs/erd` · `docs/adr` · `docs/design` · `docs/brand` · `docs/testing` · `docs/runbooks`
- `docs/marketing` (keyword map, content plan, PAID-ADS-APPENDIX) · `docs/product` (POC, MVP) · `docs/business` (model, forecast, deck, reports)

## Project-specific notes
<!-- Domain glossary, integrations (Meta app names, payment gateway), known pitfalls. -->
