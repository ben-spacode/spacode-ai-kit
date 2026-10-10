---
name: python-service
description: Scaffold or extend a Python server engine with FastAPI to Spacode standards — project layout, pydantic-settings config, SQLAlchemy 2 async + Alembic, tenant scoping, routers/services/repositories, background workers on Redis, pytest, ruff/mypy, Dockerfile for Railway. Use when the backend is Python, "שרת בפייתון", FastAPI, or an AI/data-heavy engine.
---

# Python Service (FastAPI)

Read `.cursor/rules/02-backend.mdc` and `04-database-multitenancy.mdc`.

## Scaffold (`apps/engine`)
- `pyproject.toml` with **uv** (or poetry); Python latest supported stable; versions vetted via `dependency-vetting`.
- Packages (typical): fastapi, uvicorn[standard], pydantic v2, pydantic-settings, sqlalchemy[asyncio] 2.x, asyncpg, alembic,
  redis, arq (or celery), httpx, structlog, sentry-sdk; dev: pytest, pytest-asyncio, httpx, ruff, mypy, testcontainers.
- Layout per rule 02 (`app/core`, `api/v1`, `services`, `repositories`, `models`, `schemas`, `workers`).

## Conventions
- Settings via `BaseSettings`; fail fast on missing vars.
- DB session per request (`Depends(get_session)`); tenant context from auth dependency → repositories always filter by `tenant_id`.
- Pydantic schemas for input (`extra="forbid"`) and output (never return ORM objects directly).
- Exception handlers produce the standard error body with `requestId`.
- Background jobs in `workers/` (arq on Redis): idempotent, retries, tenant in payload.
- Health: `/health/live`, `/health/ready` (DB + Redis).
- OpenAPI enabled in non-production or behind auth.

## Quality
`ruff check` + `ruff format --check`, `mypy`, `pytest` (unit + integration with Postgres/Redis), `pip-audit` — wired into the partial CI level.
Tenant-isolation test for every tenant endpoint.

## Deploy
Multi-stage Dockerfile (slim base, non-root, `uv sync --frozen --no-dev`), start `uvicorn app.main:app --host 0.0.0.0 --port $PORT`;
Railway pre-deploy `alembic upgrade head`. Worker as a separate Railway service with the same image and a different start command.
