---
name: security-review
description: Run a pre-production security review on a Spacode codebase or diff — OWASP Top 10, auth/authz, tenant isolation, secrets, webhooks, dependencies, headers, privacy/PII and Israeli privacy-law points. Use before every staging→main promotion, after auth/payment/webhook changes, or when the user asks "security review", "בדיקת אבטחה", "is this safe".
---

# Security Review

Scope: the diff being promoted (`git diff origin/main..origin/staging`) plus any touched security-critical modules.

## Checklist
**Secrets**
- [ ] No secrets in diff/history (`gitleaks detect` or search for keys, tokens, `BEGIN PRIVATE KEY`, `sk-`, `EAA` Meta tokens)
- [ ] `.env.example` has names only; new vars set per environment

**AuthN / AuthZ**
- [ ] Every new route has auth + tenant + permission guards (or is intentionally public and rate-limited)
- [ ] Object-level authorization (IDOR) — run `multi-tenant-guard` on changed modules
- [ ] Token lifetimes, refresh rotation, logout invalidation unchanged or improved

**Input / injection**
- [ ] DTO validation with whitelist; no raw SQL concatenation; HTML sanitized; file upload limits
- [ ] SSRF: user-supplied URLs fetched server-side are allowlisted
- [ ] AI features: prompt-injection handling, tools re-check permissions

**Webhooks & integrations**
- [ ] Signature verification on raw body (Meta, payment gateway); idempotency; replay protection

**Transport & headers**
- [ ] helmet, HSTS, CORS allowlist per env, cookies httpOnly/Secure/SameSite, CSRF where cookie auth

**Dependencies**
- [ ] `npm audit --audit-level=high` clean or accepted with justification; no new unmaintained packages

**Privacy**
- [ ] New PII fields documented in ERD; minimal collection; not logged; not sent to AI/analytics unmasked
- [ ] Consent recorded for marketing; opt-out works; export/delete still works for new data

**Logging & audit**
- [ ] Sensitive actions audited; errors don't leak stack traces/internal ids to clients

## Output
Findings table: `Severity | Location | Issue | Recommendation`, then a verdict: **Ship** / **Ship with follow-ups (list)** / **Block**.
