---
name: erd-designer
description: Design or update the data model (ERD) for PostgreSQL in a multi-tenant Spacode project — entities, relations, constraints, indexes, PII flags, Mermaid diagram. Use when the user asks for an ERD, DB schema, "מבנה נתונים", "טבלאות", or a PRD needs a data model.
---

# ERD Designer

## Process
1. Read the PRD (and existing `docs/erd/ERD.md` + current schema/migrations if any).
2. List entities and their relationships in plain language first; confirm anything ambiguous
   (e.g. "can a contact belong to more than one tenant?").
3. Produce the ERD in `docs/erd/ERD.md`: Mermaid `erDiagram` + a table section per entity.
4. Propose the ORM schema (Prisma/TypeORM — whichever the repo uses) as a draft; the migration itself goes through `db-migration`.

## Mandatory design rules
- Tenancy model stated at the top: shared DB + `tenant_id` column (default) / schema-per-tenant / DB-per-tenant (needs ADR).
- Tenant-owned tables: `tenant_id uuid not null` + FK to `tenants` + composite indexes starting with `tenant_id`.
- `id uuid` PK, `created_at`, `updated_at` timestamptz; `deleted_at` only where history is required.
- Unique constraints scoped per tenant.
- Money as integer agorot / numeric; phones E.164; emails lower-cased + citext or unique index on lower().
- Every FK has explicit `on delete`. Many-to-many via join table with its own PK and timestamps.
- Mark PII columns and sensitive columns (encrypted at rest at app level when needed: tokens, ID numbers).
- Standard platform tables to consider: `tenants`, `users`, `memberships(user_id, tenant_id, role)`,
  `roles/permissions`, `audit_logs`, `api_keys`, `webhook_events`, `files`, `consents`.

## Per-entity section format
```
### contacts (tenant-owned, PII)
| column | type | null | default | notes |
|---|---|---|---|---|
| id | uuid | no | gen | PK |
| tenant_id | uuid | no | | FK tenants.id, on delete cascade |
| phone | text | no | | E.164, PII |
Indexes: (tenant_id, phone) unique; (tenant_id, created_at desc)
```

## Review checklist
- Hot list queries have matching indexes. No unbounded JSONB used to dodge modelling.
- Deletion behavior makes business sense (soft vs hard, cascades).
- Data needed for reporting/analytics exists (status history, timestamps).
