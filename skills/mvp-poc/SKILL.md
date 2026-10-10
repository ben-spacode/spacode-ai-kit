---
name: mvp-poc
description: Validate a product idea with a proof of concept run on the internet (smoke-test landing page, waitlist, interviews, small ad test, concierge/manual test) with pass/fail thresholds set in advance, then define the first MVP scope with explicit cuts and success metrics. Use for "POC", "MVP", "בדיקת היתכנות", "גרסה ראשונה", idea validation.
---

# POC → MVP

Read `.cursor/rules/17-product-business.mdc`.

## POC (`docs/product/POC.md`)
1. **Riskiest assumptions** (demand, willingness to pay, channel, feasibility) — rank and pick the top 1–3.
2. **Hypothesis:** "We believe <segment> will <action> because <reason>. We'll know when <metric ≥ threshold> within <time>."
3. **Choose the cheapest web test:**
   - Smoke-test landing page + waitlist (honest "coming soon"), driven by a small paid test (e.g. a few hundred ₪) and/or organic posts
   - Problem interviews (10–15) recruited online
   - Pre-sale / letter of intent for B2B
   - Concierge / Wizard-of-Oz (manual service behind a simple front)
   - Technical spike for feasibility risks (API limits, AI quality on real samples)
4. **Thresholds in advance:** e.g. landing CVR ≥ X%, CPL ≤ Y ₪, ≥ N interviews confirming the pain, ≥ M LOIs.
5. **Run** — reuse `landing-campaign` (lightweight) and the analytics module; log results with dates and sources.
6. **Decision:** go / pivot / stop, with evidence.

## MVP (`docs/product/MVP.md`)
- Core value in one sentence; the one primary user journey end-to-end.
- **In** (must-have, MoSCoW "Must") / **Out** (explicitly cut, with when to revisit).
- Non-negotiables even in MVP: security, tenant isolation, privacy, accessibility, analytics, error tracking, backups.
- Success metrics (activation, retention, conversion) and how they're measured in the product.
- Milestones: walking skeleton → core flow → beta users → launch. Each feeds a PRD.
