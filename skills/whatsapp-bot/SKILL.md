---
name: whatsapp-bot
description: Build or extend a WhatsApp Business bot/integration on Meta Cloud API for a Spacode multi-tenant system — webhook, signature verification, inbound/outbound queues, templates, 24h window, conversation state machine, human hand-off, Embedded Signup onboarding. Use for anything WhatsApp, "בוט ווצאפ", Meta webhook, message templates, or connecting a client's number.
---

# WhatsApp Bot Builder

Read `.cursor/rules/07-whatsapp-meta.mdc` first. Verify any Graph API detail you're unsure of against
Meta's current documentation — do not guess endpoint shapes or error codes.

## A. Integration foundation (once per project)
1. Config: `META_APP_ID`, `META_APP_SECRET`, `META_WEBHOOK_VERIFY_TOKEN`, `META_GRAPH_VERSION`, system-user token (or per-tenant tokens in DB, encrypted).
2. Tables: `wa_accounts(tenant_id, waba_id, phone_number_id, display_phone, token_enc, quality_rating, status)`,
   `wa_conversations(tenant_id, contact_id, state, context jsonb, last_inbound_at, bot_paused)`,
   `wa_messages(tenant_id, conversation_id, wa_message_id unique, direction, type, payload jsonb, status, error)`,
   `wa_templates(tenant_id, name, language, category, components jsonb, status)`, `consents`.
3. Webhook controller: GET verify; POST → raw-body HMAC check → enqueue `wa-inbound` → 200.
4. Inbound processor: dedupe by message id → resolve tenant by `phone_number_id` → upsert contact/conversation → update `last_inbound_at` → route to bot/agent/inbox.
5. Outbound service: single `send(tenantId, to, message)` that checks the 24h window, picks template vs free-form, enqueues to `wa-outbound`, handles retries/rate-limit codes, stores status.
6. Status updates processor: sent/delivered/read/failed.

## B. Bot flow
- Define the flow as a state machine (states, transitions, expected input, timeouts) — write it as a Mermaid diagram in the PRD first.
- Use interactive messages (buttons ≤ 3, lists ≤ 10 rows) for choices; validate free text.
- Global intents in every state: human agent ("נציג"), restart ("תפריט"), opt-out ("הסר").
- Human hand-off sets `bot_paused=true` and notifies the inbox; resume rules defined.
- AI step (if any): follow `ai-agent-builder` — bounded tools, Hebrew system prompt, fallback to human.

## C. Templates
- Draft templates with category, Hebrew text, variables `{{1}}` + examples; explain to the user what Meta tends to reject (promotional wording in UTILITY, missing examples).
- Sync status from Meta; block sends with non-approved templates.

## D. Client onboarding (Embedded Signup)
Checklist for the human: client's Business Manager verified (if needed), number not active on WhatsApp app (or migrated),
display name approved, payment method on the WABA, webhook subscribed for the WABA, test send.

## E. Tests
- Signature verification (valid/invalid), dedupe, tenant resolution, 24h window logic, opt-out handling, state transitions.
- Use the Meta test number in dev/staging only.
