---
name: db-migration
description: Create a safe PostgreSQL migration (Prisma/TypeORM) with rollback plan and zero-downtime pattern, and prepare — not run — its application on staging/production. Use when adding/changing tables, columns, indexes, enums, backfills, or when the user says "migration", "שינוי בסכמה", "add column".
---

# Safe DB Migration

## 1. Classify the change
- **Additive / safe:** new table, nullable column, new index (`CREATE INDEX CONCURRENTLY` on large tables), new enum value.
- **Breaking:** rename/drop column or table, type change, NOT NULL on existing column, unique constraint on existing data, enum value removal.

## 2. Breaking change → expand / contract over multiple releases
1. Expand: add the new column/table (nullable), deploy code that writes to both.
2. Backfill: batched BullMQ job (e.g. 1,000 rows per batch, resumable, logged).
3. Switch: code reads from new, still writes both. Verify.
4. Contract: separate later release removes old column / adds NOT NULL.

## 3. Write the migration
- Generate with the project's tool locally only (`prisma migrate dev --name <intent>` / `typeorm migration:generate`).
- Review the generated SQL by hand: locks, defaults on big tables (avoid table rewrite), concurrent indexes.
- Write the **down** migration or a compensating migration; document if irreversible (data loss) and why.
- Update `docs/erd/ERD.md` and the PRD data section in the same PR.

## 4. Test
- Apply on a fresh DB and on a copy with realistic (anonymized) volume if the table is large.
- Run integration tests; run down → up once locally.

## 5. Prepare for promotion (human executes)
In the PR description include:
```
### Migration
- Name: <file>
- Type: additive | breaking (phase X of expand/contract)
- Estimated lock/time: <…>
- Backfill job: <name / none>
- Rollback: <steps>
- Order: migrate BEFORE / AFTER deploying code
```
Never run migrations against staging/production yourself; the deploy pipeline does it.
