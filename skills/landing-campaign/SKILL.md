---
name: landing-campaign
description: Plan and build a lead-generation landing page that is promoted on Google and social networks — campaign brief, Hebrew conversion copy, branding on the page, RTL Next.js page, lead form into the CRM and WhatsApp lead engine, organic SEO, pixels/CAPI/Google Ads tracking, A/B plan. Use for "דף נחיתה", landing page, lead capture page, campaign page.
---

# Landing Page & Campaign

Read `.cursor/rules/15-landing-branding.mdc`, `10-seo-organic.mdc`, `14-paid-marketing.mdc`.

## 1. Brief (ask if missing)
Offer, audience/persona and pains, single conversion goal, main objection, real proof available, channels
(Google organic/paid, Meta, TikTok, LinkedIn, WhatsApp), budget, KPI targets (CPL, CVR), deadline, brand guide present?
If no brand guide → run `brand-identity` first (at least a light version).

## 2. Messaging
Use `copywriting` for the copy and `marketing-psychology` for the persuasion levers (ethically); page placement in the site per `site-architecture`.
3 headline options + subheadline (benefit-led, specific), value props as outcomes, objection-handling FAQ, CTA
variants (form + WhatsApp). Organic: primary keyword + intent for the page. Ad copy is prepared in the paid appendix.

## 3. Build (Next.js `app/(site)/lp/[slug]` or a separate `landing` service)
Sections per rule 15; design from Stitch if available, motion/interaction per `apple-design` and `mobile-native`; tokens from the brand guide. Metadata + canonical + OG +
`FAQPage`/`Service` schema; in `sitemap.ts` unless it's a paid-only variant (then `noindex` + canonical to the main page).
Form → `/api/leads` → CRM (UTM, click IDs, slug, consent) → WhatsApp lead engine. Thank-you state fires `Lead` with shared `event_id`.

## 4. Quality
Lighthouse mobile ≥ 90 all categories, axe clean, 375px check, message match with ads, Hebrew proofread.

## 5. Launch
Tracking QA (Pixel/CAPI test events, GA4 DebugView, Google Ads tag assistant), Search Console URL inspection,
paid appendix updated with the page URL. A/B plan: one variable at a time; log in `docs/marketing/experiments.md`.
Weekly report: sessions by source, leads, CPL, CVR, lead quality from CRM, next actions.
