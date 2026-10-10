---
name: full-test-suite
description: Set up and maintain the complete test infrastructure for a project — partial level (lint, types, unit, build, secrets, audit) and full level (integration, contract, Playwright E2E, regression, smoke, axe accessibility, Lighthouse CI, k6 load, OWASP ZAP, CodeQL, visual regression, cross-browser, Maestro for mobile) — plus TEST-PLAN.md and CI wiring that blocks merges. Use for "בדיקות", "e2e", test plan, QA setup, performance/load/security testing.
---

# Full Test Suite

Read `.cursor/rules/06-testing-quality.mdc`. CI templates: `.github/workflows/ci-partial.yml` and `ci-full.yml`.

## 1. Test plan (`docs/testing/TEST-PLAN.md`)
Critical journeys (from PRD), risk areas, test types per layer, environments, data strategy, entry/exit criteria
per gate, owners, tools. Template in `docs/templates/TEST-PLAN.md`.

## 2. Partial level (PR → develop)
- ESLint/Prettier (ruff for Python), `tsc --noEmit` (mypy), Jest/Vitest (pytest), build, gitleaks, `pnpm audit --audit-level=high` / `pip-audit`, commitlint.

## 3. Full level (develop and above)
| Area | Setup |
|---|---|
| Integration | Postgres + Redis as CI services or Testcontainers; API tests via supertest/httpx |
| Contract | validate responses against OpenAPI (e.g. schemathesis for FastAPI/any OpenAPI) |
| E2E web | Playwright projects: chromium, webkit, firefox, mobile-chrome (Pixel), mobile-safari (iPhone); `@smoke` tag subset; `E2E_BASE_URL` per environment |
| Accessibility | `@axe-core/playwright` on every key page; fail on serious/critical |
| Visual regression | Playwright `toHaveScreenshot` on key pages, baseline updated only via reviewed PR |
| Performance | Lighthouse CI (`lighthouserc.json`, assertions ≥ 0.9) on deployed URLs |
| Load | k6 scripts in `tests/load/` — `smoke.js` (develop/staging), `load.js` (before main) with thresholds `http_req_duration p(95)<500`, `http_req_failed rate<0.01` |
| Security | CodeQL (or Semgrep) workflow; OWASP ZAP baseline scan against staging; gitleaks; OSV-Scanner |
| Mobile | Maestro flows on preview builds |
| Resilience | tests simulating timeouts/5xx from Meta, AI provider, payment gateway |

## 4. CI wiring
- Required status checks: partial jobs on `develop`; full jobs (`ci-full / *`) on `staging` and `main` PRs.
- Full suite runs against the **deployed** development/staging environment after Railway finishes deploying (wait for `/health/ready`).
- Reports (Playwright HTML, Lighthouse, ZAP, k6 summary) uploaded as artifacts and linked in promotion PRs.

## 5. Maintenance
Track flaky tests (issue per flake), keep runtime of partial level < 10 min, review coverage trend monthly.
