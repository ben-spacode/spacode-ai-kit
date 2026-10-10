---
name: prd-writer
description: Write or update a Product Requirements Document (PRD) in Spacode's format for a feature, epic or whole product. Use when the user asks for a PRD, "מסמך דרישות", "אפיון", spec, user stories or acceptance criteria, or before implementing any new feature.
---

# PRD Writer

## Process
1. Gather: problem, users, goal, scope. If the user gave only an idea, ask up to 6 sharp questions
   (who, what problem, what does success look like, must-have flows, integrations, constraints). Then write.
2. Write to `docs/prd/PRD-<nnn>-<slug>.md` using `docs/templates/PRD.md` if present, else the structure below.
3. Write in the user's language (usually Hebrew), keep technical terms in English.
4. End with **Open questions** — never hide uncertainty inside the spec.

## Structure
```
# PRD-<nnn>: <Title>
Status: Draft | In review | Approved | Shipped    Owner: <name>    Updated: <date>

## 1. Problem & context
## 2. Users / personas (and roles/permissions)
## 3. Goals & success metrics (measurable)
## 4. Scope — In / Out (explicit non-goals)
## 5. User stories & acceptance criteria
   US-1: As a <role> I want <action> so that <benefit>
     - Given … When … Then …
## 6. Flows & UX (Figma links, screens list, empty/error states, RTL notes)
## 7. Data (entities touched, PII fields, retention) → link ERD
## 8. Integrations (WhatsApp, payments, email, AI, external APIs) with failure behavior
## 9. Non-functional (performance, security, privacy, accessibility, multi-tenant, i18n)
## 10. Analytics & tracking events
## 11. Rollout (feature flag, migration, client communication)
## 12. Risks & mitigations
## 13. Open questions
```

## Quality checks before finishing
- Every user story has testable acceptance criteria.
- Permissions are explicit per role. Multi-tenant impact stated.
- Failure states covered (integration down, empty data, no permission).
- Nothing in scope is untestable or vague ("fast", "nice") — replace with numbers.
