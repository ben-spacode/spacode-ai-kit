---
name: multi-tenant-guard
description: Audit code, queries, jobs and schema for multi-tenant data-isolation bugs and fix them — missing tenant_id filters, IDOR, unscoped unique constraints, jobs without tenant context, RLS. Use before every staging→main promotion, after adding endpoints, or when the user asks "check tenant isolation", "בידוד בין לקוחות", "data leak between tenants".
---

# Multi-Tenant Guard

## Scan
Search the codebase for:
1. **Unscoped queries** on tenant-owned tables: `findMany`, `findFirst`, `findUnique`, `update`, `delete`,
   `createQueryBuilder`, raw SQL (`$queryRaw`, `query(`) without `tenantId`/`tenant_id`.
2. **Lookup by id only**: `findUnique({ where: { id } })` / `findOne(id)` followed by return/update — must also match tenant.
3. **Tenant from client input**: `body.tenantId`, `query.tenantId`, headers other than the resolved context.
4. **Jobs/webhooks/cron** that touch tenant data without setting tenant context from the payload.
5. **Schema**: tenant-owned tables missing `tenant_id NOT NULL`, missing index, or global `UNIQUE` that should be per tenant.
6. **Caches** (Redis keys) without tenant prefix; **file storage** paths without tenant prefix; **search/vector** queries without tenant filter.
7. **Admin / super-admin routes** that bypass tenant scope — must be explicitly guarded and audited.

## Report
Table: `Severity (Critical/High/Medium) | File:line | Issue | Fix`. Critical = possible cross-tenant read/write.

## Fix
- Move scoping into the repository/ORM extension so it can't be forgotten.
- Add a test per finding: create two tenants, act as tenant A against tenant B's resource → expect 404/403.
- Optional hardening: Postgres RLS policy `USING (tenant_id = current_setting('app.tenant_id')::uuid)` + set per transaction.

Never mark the audit "clean" without listing what was checked.
