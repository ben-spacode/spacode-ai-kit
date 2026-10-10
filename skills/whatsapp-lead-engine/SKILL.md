---
name: whatsapp-lead-engine
description: Build the official WhatsApp (Meta Cloud API) lead engine for a system — lead capture from click-to-WhatsApp ads, website and QR with source tagging, lead warming sequences with templates and quiet hours, lead assignment by group and source with SLA and re-assignment, CRM sync and reporting. Use for "יצירת לידים בווצאפ", "חימום לידים", "שיוך לידים", lead routing, nurturing, WhatsApp marketing automation.
---

# WhatsApp Lead Engine

Prerequisite: WhatsApp foundation from the `whatsapp-bot` skill (webhook, queues, templates, conversations).
Read `.cursor/rules/07-whatsapp-meta.mdc`.

## 1. Data model (add to ERD)
`leads(tenant_id, contact_id, source, medium, campaign, ad_id, landing_slug, group_id, stage, score, assigned_to, assigned_at, first_response_at, consent_marketing, consent_at)`
`lead_groups(tenant_id, name, rules jsonb)` · `assignment_rules(tenant_id, priority, match jsonb, group_id, strategy)`
`sequences(tenant_id, name, trigger, steps jsonb, active)` · `sequence_enrollments(lead_id, sequence_id, step, next_run_at, status)`
`lead_events(lead_id, type, payload, created_at)`

## 2. Capture with source
- Click-to-WhatsApp ads: read `referral` object in the webhook (ad id, source URL, headline) → source/campaign.
- Website/landing buttons: `wa.me/<number>?text=<prefilled with ref code>`; ref code maps to source/landing/UTM.
- QR codes per channel/location with distinct ref codes. Forms → lead + welcome template.
- Dedupe by phone per tenant; keep first-touch and last-touch attribution.

## 3. Assignment by group / source
Rules evaluated by priority: match on source, campaign, landing, product interest, region, language, time → group.
Within a group: round-robin, weighted, or least-loaded among available agents (working hours). SLA timer (e.g. 5 min in
working hours) → notify, then re-assign if no first response. All decisions logged in `lead_events`.

## 4. Warming (nurturing) sequences
- Triggered by stage/behavior (new lead, no reply 24h, viewed pricing, meeting no-show).
- Steps: approved template outside 24h window, free-form/interactive inside it; delays; branch on reply/button.
- Guardrails: marketing consent required for MARKETING templates, frequency cap per lead, quiet hours and Shabbat/holiday
  pause (configurable per client), stop on reply/opt-out/assignment to human, respect number quality rating.
- Run by a scheduler job (`next_run_at`) in the worker; idempotent per step.

## 5. Scoring & CRM
Simple score from engagement (replies, clicks, form fields) and fit; stage changes sync to CRM and back to ad platforms
as offline conversions (qualified / won).

## 6. Reporting
Leads by source/campaign/group, response time, SLA breaches, conversion per sequence step, opt-out rate, cost per lead.

## Tests
Source attribution, rule matching order, round-robin fairness, SLA re-assignment, quiet hours, consent enforcement, opt-out stop.
