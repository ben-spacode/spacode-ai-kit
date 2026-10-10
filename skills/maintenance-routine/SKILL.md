---
name: maintenance-routine
description: Run Spacode's recurring maintenance routine on a live project — dependency and security updates, error-tracker triage, queue and DB health, backup restore test, cost review, token/certificate/API-version expirations, access review — and produce a short report. Use for "תחזוקה שוטפת", monthly/quarterly maintenance, health check of a project in production.
---

# Maintenance Routine

## Monthly
1. **Dependencies:** review Dependabot/Renovate PRs; `npm audit`; update patch/minor in `develop`, majors via ticket.
2. **Errors:** top 10 errors in Sentry by frequency/users → ticket or resolve; check new error types since last month.
3. **Queues:** failed jobs per queue, retries trend, oldest waiting job; clean or fix.
4. **Database:** size growth, slow queries (pg_stat_statements), missing indexes, bloat; connection usage.
5. **Backups:** restore latest production backup into staging (anonymize if exposed) and verify app boots.
6. **Costs:** hosting, AI tokens per tenant, WhatsApp conversation costs; flag anomalies.
7. **Uptime & performance:** uptime %, p95 latency, Core Web Vitals for public pages.

## Quarterly
- Access review: GitHub, hosting, Meta Business, payment gateway, AI providers — remove leavers, least privilege.
- Secret rotation where policy requires; check System User tokens and webhook subscriptions.
- Expirations: domains, SSL, Meta Graph API version deprecation dates, Node.js LTS end-of-life, framework majors.
- Review rules/skills in the Spacode kit against lessons learned (postmortems).

## Report (Hebrew, to `docs/maintenance/YYYY-MM.md`, short version for the client)
Status (🟢/🟡/🔴) per area, actions taken, issues opened, recommendations, items needing client decision/budget.
