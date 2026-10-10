---
name: customer-service-agent
description: Build the one AI customer-service agent every Spacode system gets, on an expandable agents service — knowledge base, channels (website chat, WhatsApp, admin inbox), tools (create lead/ticket, look up status, book), human hand-off, Claude API or OpenAI API via config, evals, and the agent registry that lets new agents be added later. Use for "סוכן שירות לקוחות", "צ'אטבוט לאתר", AI support agent, or when setting up the agents service.
---

# Customer-Service Agent + Agents Service

Read `.cursor/rules/08-ai-agents.mdc` and `07-whatsapp-meta.mdc`. For deeper agent design use `ai-agent-builder`.

## 1. Agents service (`apps/agents`, own Railway service)
```
providers/      LlmProvider interface + anthropic.ts + openai.ts (selected by AI_PROVIDER / per-agent override)
registry/       agent definitions: { id, name, systemPromptFile, tools[], model, limits, channels[] }
agents/
  customer-service/  SPEC.md · system.he.md · tools.ts · evals/
runtime/        conversation loop, max steps, timeout, streaming, structured output, fallback
knowledge/      ingestion → chunks (pgvector, tenant_id) → retrieval with sources
channels/       web-chat (SSE/WebSocket API), whatsapp (consumes wa-inbound queue), admin-inbox
usage/          tokens, cost, latency per tenant/agent; budget enforcement
```
Adding an agent later = new folder under `agents/` + registry entry + evals. The core runtime doesn't change.

## 2. Customer-service agent spec (fill `SPEC.md` with the client)
Scope (FAQ, services, pricing, hours, order/lead status), out-of-scope topics, tone (from brand guide), languages,
escalation rules (angry customer, legal/medical/financial, payment issues, explicit request → human), SLA for human reply.

## 3. Knowledge base
Sources: website pages, FAQ, policies, price list, admin-managed Q&A. Admin screen to add/edit knowledge; re-index on change.
Answers cite the source internally; unknown → say so and offer a human, never invent.

## 4. Tools (tenant-scoped, permission-checked)
`create_lead(name, phone, need, source)`, `create_ticket(summary, priority)`, `get_status(ref)`,
`book_meeting(slot)` (if calendar), `handoff_to_human(reason)`. Side-effect tools log to audit; no payments by the agent.

## 5. Channels
- Website widget in `app/(site)` (lazy-loaded, RTL, accessible, discloses it's an AI assistant, consent note).
- WhatsApp: inbound messages routed to the agent unless `bot_paused`; respects 24h window; hand-off pauses the bot.
- Admin inbox: humans see all conversations, take over, return to bot.

## 6. Quality
≥ 20 Hebrew eval cases (FAQ, edge cases, angry user, out-of-scope, prompt injection, PII requests) run in CI on prompt/model/provider changes.
Metrics dashboard: resolution rate, hand-off rate, CSAT (thumbs), cost per conversation.
