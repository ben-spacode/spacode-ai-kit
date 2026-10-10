---
name: incident-postmortem
description: Handle a production incident and write a blameless postmortem — triage steps, communication to the client, timeline, root cause (5 whys), action items, and updating rules/skills so it doesn't recur. Use when production is down/broken, "תקלה בפרודקשן", "incident", "postmortem", "תחקיר".
---

# Incident & Postmortem

## During the incident (stabilize first)
1. Severity: S1 (down / data leak / payments broken), S2 (major feature broken), S3 (degraded), S4 (minor).
2. Stabilize: roll back to the previous release if the incident started after a deploy; disable via feature flag; pause the failing queue.
3. Gather evidence: error tracker, logs (by requestId/tenantId), recent deploys/migrations, Meta/provider status pages.
4. Communicate: short Hebrew status update to the client — what's affected, what we're doing, next update time. Draft it for the human to send.
5. For any suspected **data leak between tenants or personal-data breach**: escalate to the CTO immediately — there may be legal notification duties under Israeli privacy regulations.

## Postmortem (within 3 business days) → `docs/postmortems/YYYY-MM-DD-<slug>.md`
```
# Postmortem: <title>
Severity: S1–S4   Duration: <start–end, Asia/Jerusalem>   Status: Draft/Final
## Summary (3 lines, Hebrew, client-safe)
## Impact (tenants/users affected, data, money, SLA)
## Timeline (detection → response → mitigation → resolution)
## Root cause (5 whys — systems and process, not people)
## What went well / what went poorly
## Action items | owner | due | issue link
## Prevention: rules/skills/tests updated
```

## Close the loop
For each root cause, propose a concrete change to: a test, a CI gate, a monitoring alert, a rule in
`.cursor/rules/`, or a skill in the Spacode kit — and open a PR to the kit repo if it's a general lesson.
