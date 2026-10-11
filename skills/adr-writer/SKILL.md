---
name: adr-writer
description: Record an Architecture Decision Record (ADR) — stack, hosting (Railway vs AWS), libraries, tenancy model, integrations, AI provider. Use when a hard-to-reverse technical choice is being made, or the user says "ADR", "החלטה ארכיטקטונית", "why did we choose", or deviates from the Spacode default stack.
---

# ADR Writer

1. Find the next number in `docs/adr/` (`ADR-0001`, `ADR-0002`, …).
2. Write `docs/adr/ADR-<nnnn>-<slug>.md`:

```
# ADR-<nnnn>: <Decision title>
Status: Proposed | Accepted | Superseded by ADR-xxxx    Date: <yyyy-mm-dd>    Deciders: <names>

## Context
What forces are at play: requirements, constraints (budget, compliance, team, timeline), current state.

## Decision
The choice, stated in one or two sentences, then details.

## Alternatives considered
| Option | Pros | Cons | Why not |

## Consequences
Positive, negative, follow-up work, risks, how we'd reverse it and at what cost.
```

3. Accepted ADRs are immutable. To change a decision, write a new ADR and mark the old one `Superseded`.

## Hosting guide (for ADR-0001) — Railway is the default; AWS when the client's needs call for it
- Railway: budget-sensitive client, ≤ medium load, small team, need speed, no strict compliance. Watch: egress cost, region (latency to Israel), backup policy.
- AWS: compliance/enterprise, client-owned account, high scale or VPC needs, services beyond basics (SQS, Bedrock, etc.). Requires IaC and higher ops effort; region `il-central-1` (Tel Aviv) for data residency if required.
