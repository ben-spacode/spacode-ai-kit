---
name: project-kickoff
description: Start a new Spacode project end-to-end and drive it through the full lifecycle — discovery, POC, PRD/ERD/ADR, brand, Stitch design, skeleton, Railway services, SEO/pixels/marketing readiness, AI agent and WhatsApp, MVP, launch and post-launch business deliverables. Use when the user says "new project", "פרויקט חדש", "kickoff", "let's start a project for <client>", or asks what the next stage of a project is.
---

# Project Kickoff & Lifecycle Driver

Goal: take a new project from idea to launch and beyond, in the right order, using the other skills. Keep a
living checklist in `docs/PROJECT-STATUS.md` (copy the phase list below, tick items, link outputs).

## Phase 0 — Discovery (ask, grouped, in Hebrew; max ~10 questions per round)
1. Client, industry, problem, end users, expected tenants/users.
2. Project type: website + admin system / landing page / mobile app (Expo) / combination; does it need a separate server engine (Node.js or Python)?
3. Core flows for v1 (3–5).
4. Integrations: WhatsApp (own number, Embedded Signup), payments, invoicing, email, calendars, existing systems.
5. AI: which customer-service scope; provider preference (Claude API / OpenAI API).
6. Marketing: organic goals (keywords, regions), social networks, paid channels and budget, existing brand assets.
7. Design: reference site(s) for Stitch; brand assets; who approves design.
8. Data & privacy: personal data, retention, ownership. Hosting constraints (budget, compliance, client-owned AWS account?) → Railway or AWS.
9. Timeline, budget, maintenance agreement.
10. Success metrics at 3 and 12 months; is an investor deck / business reporting needed?

## Phase 1 — Validate (POC)
Skill `mvp-poc` → `docs/product/POC.md`: hypothesis, web test (smoke landing / waitlist / interviews / small ad test), pass/fail thresholds. Proceed only on pass (or a documented pivot).

## Phase 2 — Define
- `prd-writer` → `docs/prd/PRD-001-<slug>.md`
- `erd-designer` → `docs/erd/ERD.md`
- `adr-writer` → ADR-0001 (stack, hosting Railway or AWS, services, AI provider, engine language)
- `business-model` → current model `docs/business/BUSINESS-MODEL.md`
- `mvp-poc` → MVP scope `docs/product/MVP.md`
- `brand-identity` → `docs/brand/BRAND-GUIDE.md`
- `site-architecture` → page hierarchy, navigation, URLs (public sites)
- Marketing order for the whole project: follow `growth-engine`
- `dependency-vetting` → framework/runtime versions recorded in the ADR

## Phase 3 — Repository & infrastructure (prepare; human executes)
- [ ] Private GitHub repo from template; `install-spacode-kit.sh` applied; `setup-github.sh` run (branches, protection, environments).
- [ ] Local machine: clone and keep only `develop` (`git switch develop`; delete local `main` if created by clone).
- [ ] Hosting per ADR-0001 — **Railway:** project with 3 environments and a service per component (`deploy-railway`); **AWS:** IaC for 3 environments, ECS service per component, RDS, ElastiCache, OIDC role per environment (`deploy-aws`). Set GitHub variable `HOSTING`.
- [ ] Domains + DNS; dev/staging protected + noindex.
- [ ] `.cursor/mcp.json` with Stitch; `STITCH_API_KEY` in the developer environment.
- [ ] Sentry, uptime monitoring, Search Console, GA4, Meta Business assets (Pixel, WABA), Google Ads account.
- [ ] Secrets set per environment (never pasted into chat).

## Phase 4 — Skeleton
Monorepo apps (web site+admin, engine, worker, agents, mobile if needed), auth, tenant model, design tokens,
`components/ui`, CI partial + full workflows, SEO foundation (`seo-foundation`), analytics/pixels module,
health endpoints, first deploy to development through GitHub. Test plan via `full-test-suite`.

## Phase 5 — Design
`stitch-design`: reference → Stitch screens via MCP → pull into the ready skeleton → adapt to tokens/RTL.

## Phase 6 — Build MVP
Features via `nestjs-module` / `python-service` / `nextjs-feature` / `expo-eas-app`; `customer-service-agent`;
`whatsapp-lead-engine`; landing pages via `landing-campaign`; content pipeline via `content-engine`.
Every feature: PR → develop (partial) → promote with `release-promotion` (full).

## Phase 7 — Launch
`security-review`, `multi-tenant-guard`, full load test, UAT, `paid-ads-appendix` ready, store submission (apps),
`release-promotion` to `main`, Search Console sitemap submitted, `client-handoff`.

## Phase 8 — After completion
`business-model` (future forecast), `investor-deck`, `periodic-reports` (quarterly/annual infrastructure),
`maintenance-routine` monthly, and the optimization loop of `growth-engine` (`gsc-ctr-optimizer` monthly, `competitor-content-gap` quarterly).

## Output each time
Short Hebrew summary: phase, decisions, open questions, and the checklist of what the human needs to do next.
