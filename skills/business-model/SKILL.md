---
name: business-model
description: Build the project's current business model (Lean Canvas / Business Model Canvas, pricing, unit economics) and a future business model forecast (3–5 years, conservative/base/optimistic scenarios, assumptions table, revenue, costs, cash, KPIs) as documents and a spreadsheet. Use for "מודל עסקי", "תחזית", forecast, pricing model, unit economics.
---

# Business Model — Present & Forecast

Read `.cursor/rules/17-product-business.mdc`. Numbers are either measured (source + date) or explicit assumptions.

## Current model (`docs/business/BUSINESS-MODEL.md`)
- Lean Canvas: problem, segments, UVP, solution, channels, revenue streams, cost structure, key metrics, unfair advantage.
- Pricing: model (subscription per tenant/seat, usage, setup fee, transaction), tiers, Israeli VAT handling, competitor price points.
- Unit economics: ARPA, gross margin (hosting, AI tokens, WhatsApp conversation costs, payment fees), CAC by channel, payback, LTV, LTV:CAC.
- Cost base: Railway, third-party APIs, AI usage, support, marketing.

## Future forecast (`docs/business/FORECAST.md` + spreadsheet)
- Horizon 3–5 years, monthly for year 1, quarterly/annual after.
- Drivers: traffic/leads by channel → conversion → new customers; churn; expansion; price changes.
- Costs: COGS per customer, fixed costs, hiring plan, marketing budget.
- Outputs: MRR/ARR, revenue, gross profit, EBITDA, cash balance, runway, customers, break-even month.
- Scenarios: conservative / base / optimistic with the assumption differences listed.
- Sensitivity: which 3 assumptions move the result most.
- Build the spreadsheet with formulas (not hard-coded results) so assumptions can be changed; if a spreadsheet skill/artifact type is available use it.

## Notes
Management forecast, not accounting statements — final financials with the client's accountant. Update quarterly from `periodic-reports` actuals.
