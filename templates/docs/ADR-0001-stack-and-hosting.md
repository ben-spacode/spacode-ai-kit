# ADR-0001: Stack and hosting for {{PROJECT_NAME}}

**Status:** Proposed · **Date:** <yyyy-mm-dd> · **Deciders:** Ben Efraimov (CTO)

## Context
<Client, expected load, budget, compliance, timeline, team.>

## Decision
- Stack: NestJS (api + worker), Next.js (web), PostgreSQL, Redis + BullMQ, TypeScript.
- ORM: <Prisma | TypeORM>
- Hosting: <Railway (project <name>) | AWS (account(s), region e.g. il-central-1)>, environments development / staging / production; one service per component (web, landing, engine, worker, agents, postgres, redis). Deploy: GitHub Actions `pipeline.yml` with `HOSTING=<railway|aws>`.
- Why this hosting: <budget, compliance, client-owned account, scale>.
- Mobile (if any): Expo + EAS (profiles development / preview / production).
- AI provider for agents: <Claude API | OpenAI API>.
- Tenancy: shared DB with `tenant_id` + <RLS yes/no>.
- Error tracking: <Sentry>. Email: <provider>. Payments: <gateway>. AI provider: <provider/model>.

## Alternatives considered
| Option | Pros | Cons | Why not |
|---|---|---|---|

## Consequences
<Cost estimate per month per environment, ops effort, migration path if we outgrow it.>
