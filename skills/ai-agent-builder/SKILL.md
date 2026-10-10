---
name: ai-agent-builder
description: Design and implement an LLM-powered AI agent or AI feature in a Spacode project — use-case definition, system prompt file, tools with schemas, tenant-scoped RAG, guardrails, cost limits, evals in CI. Use when the user asks for "סוכן AI", AI agent, chatbot brain, LLM feature, RAG, or AI-based CRM capabilities.
---

# AI Agent Builder

Read `.cursor/rules/08-ai-agents.mdc` first.

## 1. Agent spec (write before code, in `src/modules/ai/agents/<agent>/SPEC.md`)
- Job to be done, users, channel (web chat / WhatsApp / internal back-office / batch).
- Inputs available (tenant data, conversation, documents), outputs (text, structured JSON, actions).
- Tools it may call and what each is allowed to change. Which actions need human approval.
- Hard limits: what it must never do or say; escalation rules.
- Success metrics: resolution rate, accuracy on evals, latency p95, cost per conversation.

## 2. Implementation
- `prompts/<agent>.system.md` — role, tone (Hebrew, business register), rules, tool usage guidance, output format, refusal/escalation rules. Keep stable parts first (cacheable), dynamic context last.
- `tools/*.ts` — zod schema, tenant + permission checks inside the tool, idempotent where possible.
- `agents/<agent>/agent.ts` — loop with max steps, timeout, structured output parsing, fallback.
- Provider via the `LlmProvider` interface; model + params from config.
- RAG (if needed): pgvector table with `tenant_id`, chunking strategy documented, retrieval filtered by tenant, return sources.
- Usage logging: tenant, agent, model, tokens, latency, cost; enforce per-tenant budget.

## 3. Guardrails
- Prompt-injection defenses: retrieved/user content wrapped and labelled as data; tools re-check permissions.
- PII minimization before sending to the model; no full prompt/response logging in prod.
- Human hand-off path always available.

## 4. Evals
- `evals/<agent>.cases.jsonl`: ≥ 20 cases — typical Hebrew requests, edge cases, wrong/ambiguous input, injection attempts, out-of-scope.
- Each case: input, context fixture, expected behavior (exact field / contains / rubric judged by a model).
- `pnpm eval:<agent>` script; CI job runs on changes to prompts, tools or model config. Report pass rate in the PR.

## 5. Rollout
Feature flag per tenant, shadow mode or internal-only first, monitor cost and quality, then expand.
