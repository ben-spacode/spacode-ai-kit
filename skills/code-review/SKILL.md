---
name: code-review
description: Review a PR or diff against Spacode standards (NestJS, Next.js, Postgres, BullMQ, RTL, multi-tenant, tests) and return prioritized, actionable comments. Use when the user asks to review code, a PR, a branch or a diff ("תעשה CR", "review this PR").
---

# Code Review (Spacode standards)

## Gather
`git diff origin/develop...HEAD` (or the PR diff). Read the linked PRD/ticket to judge intent.

## Review dimensions (in priority order)
1. **Correctness** — does it meet the acceptance criteria? edge cases, error paths, race conditions, timezones, money math.
2. **Security & tenancy** — guards, tenant scoping, IDOR, validation, secrets, PII in logs.
3. **Data** — migration safety, indexes for new queries, N+1 queries, transactions where needed.
4. **Architecture** — follows module layout; no business logic in controllers/components; no cross-module repository access; async work in queues.
5. **Tests** — meaningful tests for new behavior and the bug being fixed; tenant-isolation test for new endpoints.
6. **Frontend** — RTL logical properties, i18n strings, loading/empty/error states, a11y, `data-testid`.
7. **Maintainability** — naming, duplication, dead code, overly clever code, TODOs without issues.
8. **Docs** — PRD/ERD/ADR/CHANGELOG/.env.example updated.

## Output format
```
### Verdict: Approve | Approve with nits | Request changes
### Must fix
- [file:line] issue → suggested fix (code snippet if short)
### Should fix
### Nits
### What's good
```
Be specific and brief. Don't nitpick formatting that Prettier/ESLint already enforce.
