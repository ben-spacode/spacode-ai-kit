---
name: periodic-reports
description: Build the infrastructure for quarterly and annual reports after project completion — KPI definitions, metrics data model and SQL views, scheduled snapshot jobs, admin reports dashboard, export, and report templates (product, marketing, business, operations). Use for "דוחות רבעוניים", "דוח שנתי", KPI dashboard, business reporting.
---

# Quarterly & Annual Reports Infrastructure

Read `.cursor/rules/17-product-business.mdc`.

## 1. KPI catalog (`docs/business/reports/KPI-CATALOG.md`)
For each KPI: name, definition, formula, source tables, owner, frequency, target.
Typical: new tenants/customers, active users (DAU/MAU), MRR/ARR, churn, NRR, ARPA, leads by source, CPL/CAC,
conversion rates, WhatsApp conversations & response time, AI agent resolution rate & cost, uptime, incidents,
organic traffic/indexed pages/top keywords, app installs/ratings.

## 2. Data layer
- `metrics_snapshots(tenant_id nullable, metric, period_type [day|month|quarter|year], period_start, value numeric, dims jsonb)`.
- SQL views / materialized views per KPI; scheduled job (worker) computes daily snapshots and rolls up month/quarter/year
  (period boundaries in `Asia/Jerusalem`).
- External data (GA4, Search Console, Meta/Google Ads spend) imported by scheduled jobs via their APIs where credentials exist; otherwise CSV import screen.

## 3. Admin reports area (`app/(admin)/admin/reports`)
Period selector (Q1–Q4, year, custom), KPI cards with change vs previous period, charts, tables, export CSV/PDF,
role-restricted. Super-admin cross-tenant view for SaaS operators.

## 4. Report templates (`docs/business/reports/`)
- `QUARTERLY-REPORT.md` — executive summary, KPIs vs targets, product releases, marketing results, operations/incidents, risks, next-quarter goals.
- `ANNUAL-REPORT.md` — year in review, KPI trends, financial summary vs forecast, roadmap.
Reports are generated from snapshots (reproducible), reviewed by the CTO, and forecast assumptions in `business-model` are updated with actuals.

## Note
Management reports, not statutory financial statements.
