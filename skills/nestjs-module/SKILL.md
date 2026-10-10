---
name: nestjs-module
description: Scaffold or extend a NestJS domain module to Spacode standards — entity/schema, DTOs, service with tenant scoping, controller with guards, Swagger, BullMQ job, unit and tenant-isolation tests. Use when creating a new backend resource, CRUD, endpoint or service ("תבנה מודול", "new endpoint", "CRUD for X").
---

# NestJS Module Builder

## Before writing
- Read `.cursor/rules/02-backend.mdc` and `04-database-multitenancy.mdc`.
- Inspect one existing module in the repo and mirror its patterns (ORM, auth decorators, tenant context helper, response shapes).
- Confirm the PRD user stories and ERD entity exist. If the entity is new → `erd-designer` + `db-migration` first.

## Generate (in this order)
1. `entities/` or schema model (if not already from migration).
2. `dto/create-<x>.dto.ts`, `dto/update-<x>.dto.ts` (PartialType), `dto/query-<x>.dto.ts` (pagination, filters, sort whitelist), `dto/<x>.response.ts`.
3. `<x>.repository.ts` (if the project uses repositories): every method takes/derives `tenantId`.
4. `<x>.service.ts`: business rules, transactions, permission checks for sensitive actions, emits domain events / enqueues jobs.
5. `<x>.controller.ts`: `@Controller('v1/<xs>')`, `@UseGuards(AuthGuard, TenantGuard, PermissionsGuard)`, `@ApiTags`, DTO-typed params, maps entities → response DTOs (never return raw entities with internal fields).
6. `jobs/<x>.processor.ts` if async work is needed (idempotent, retries, tenantId in payload).
7. Register in `<x>.module.ts` and the app module.
8. Tests: `<x>.service.spec.ts` (rules, edge cases) + integration/e2e spec including **"tenant A cannot read/update/delete tenant B's <x>"**.

## Endpoint checklist
- [ ] Input validated, unknown fields rejected
- [ ] Tenant scoping in the data layer
- [ ] Object-level authorization (IDOR-safe)
- [ ] Pagination + max limit on lists, sort fields whitelisted
- [ ] Errors use the global error format and correct status codes
- [ ] Swagger documented
- [ ] Audit log for create/update/delete of sensitive data
- [ ] No PII in logs
- [ ] Tests pass; lint/typecheck pass

Finish by listing files created/changed and any env vars or migrations required.
