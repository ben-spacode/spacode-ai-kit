---
name: paid-ads-appendix
description: Prepare a project's paid-marketing readiness and write its appendix file docs/marketing/PAID-ADS-APPENDIX.md — tracking infrastructure check, knowledge base (goals, personas, messaging, channels, budget), and an executable action plan for Meta, Google, TikTok and LinkedIn with campaign structure, targeting, keywords, ad copy, creatives brief, launch and optimization checklists. Use for "שיווק ממומן", "קמפיין ממומן", "נספח שיווק", ads setup, Google Ads, Meta Ads.
---

# Paid Ads Appendix

Read `.cursor/rules/14-paid-marketing.mdc`. Start from the template `docs/templates/PAID-ADS-APPENDIX.md`.

## 1. Infrastructure audit (in code — fix gaps before writing the plan)
- [ ] Meta Pixel + CAPI with `event_id` dedup; events: PageView, ViewContent, Lead, Contact, CompleteRegistration, Purchase
- [ ] Google Ads conversion tag + enhanced conversions; GA4 key events linked to Google Ads
- [ ] UTM + click IDs stored on leads; offline conversion export (qualified/won) to Meta & Google
- [ ] Landing pages per campaign with message match; Lighthouse ≥ 90
- [ ] Audiences: visitors, engaged, leads by stage, customers (consented, hashed)
Report gaps as tickets.

## 2. Knowledge section (fill with the user; mark assumptions)
Goal & KPIs (targets for CPL/CPA/ROAS/close rate), unit economics (max affordable CPA = margin × close rate),
personas & pains, offer, positioning/messaging pillars (from brand guide), competitor ads research (Meta Ad Library,
Google Ads Transparency Center), channel strategy per persona, budget split and test budget, policy notes
(special ad categories for housing/employment/credit, health claims, Israeli spam/consumer law).

## 3. Action plan section
Per platform:
- **Account structure** + naming: `<platform>_<objective>_<audience>_<offer>_<yyyymm>`
- **Meta:** objective, Advantage+ vs manual audiences, placements, budget (CBO/ABO), 3–5 creatives × 3 primary texts × 3 headlines, lead form vs landing page vs click-to-WhatsApp.
- **Google:** Search campaigns by intent cluster (from keyword map), match types, **negative keyword list**, RSA assets (15 headlines/4 descriptions, Hebrew, pinned where needed), extensions/assets, PMax only with good conversion data, bidding progression (Maximize conversions → tCPA).
- **TikTok / LinkedIn** when relevant to the persona.
- **Creative brief:** sizes, hooks, first 3 seconds, UGC/testimonial (real only), Hebrew captions.
- **Launch checklist**, **QA tracking checklist**, **test plan** (one variable), **weekly optimization routine** (search terms, frequency, CPA by ad set, creative fatigue), **report template**.
Each action row: platform · exact setting · owner · needs approval (yes/no) · status.

## 4. Deliver
Write `docs/marketing/PAID-ADS-APPENDIX.md`. Summarize in Hebrew: readiness score, gaps, first 2 weeks plan.
Never launch or change budgets yourself.
