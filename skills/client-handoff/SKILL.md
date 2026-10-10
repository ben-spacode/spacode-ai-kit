---
name: client-handoff
description: Produce the client handoff and maintenance package at launch or milestone end — Hebrew operating guide, admin/user guides, system map, access & credentials ownership list, SLA and maintenance scope, support process. Use when the user says "מסירה ללקוח", "handoff", "launch docs", "מסמך תחזוקה", or a project moves to maintenance.
---

# Client Handoff

Write to `docs/handoff/` in Hebrew, client-friendly language (no internal jargon), plus an internal appendix.

## Client-facing documents
1. **מדריך מערכת** — what the system does, main screens, roles & permissions, common tasks step by step (with screenshots placeholders).
2. **מדריך אדמין** — managing users, settings, WhatsApp templates/number, integrations, exports.
3. **מפת המערכת** — simple diagram: web app, API, database, WhatsApp/Meta, payment, email, AI provider, hosting.
4. **נכסים ובעלות** — table of every asset and who owns it: domain, DNS, hosting account, Meta Business/WABA, payment gateway, email provider, AI provider keys, GitHub repo, analytics/pixel. Ownership and admin access listed — **no passwords or secrets in the document**.
5. **הסכם תחזוקה (תקציר)** — what's included (monitoring, security updates, backups, bug fixes, hours/month), response times by severity, what is billed separately, how to open a request.
6. **פרטיות ואבטחה** — what personal data is stored, where (region), backups, retention, how to request export/deletion.

## Internal appendix (`docs/handoff/internal.md`)
Runbooks links, environment table, monitoring/alerts, known issues & tech debt, upcoming expirations (domains, SSL, tokens, Meta Graph version), contact list.

## Checklist before handoff
- [ ] Production smoke test passed and recorded
- [ ] Backups verified with a restore test
- [ ] Monitoring alerts route to Spacode (and client if agreed)
- [ ] Client admin accounts created; Spacode access per maintenance agreement
- [ ] Final release tagged; CHANGELOG up to date
