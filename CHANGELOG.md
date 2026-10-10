# Changelog — Spacode AI Kit

## [2.1.0] — 2026-10-09
### Added
- AI-INSTALL.md — exact instructions for an AI agent given the repo URL
- scripts/bootstrap.sh — clone to temp + install + clean up in one command

## [2.0.0] — 2026-10-08
### Added
- Rules: 12-mobile-expo, 13-dependencies-supply-chain, 10-seo-organic, 14-paid-marketing, 15-landing-branding, 16-design-stitch, 17-product-business
- Skills: seo-foundation, content-engine, brand-identity, paid-ads-appendix, stitch-design, expo-eas-app, python-service,
  dependency-vetting, full-test-suite, customer-service-agent, whatsapp-lead-engine, mvp-poc, business-model, investor-deck, periodic-reports
- Workflows: ci-partial (partial level), pipeline (full level + Railway deploy + post-deploy tests), promotion (order guard + load test), codeql, eas
- Test tooling: Playwright (5 browsers/devices, axe, visual), Lighthouse CI, k6 smoke/load, ZAP rules
- .cursor/mcp.json for Stitch; Next.js SEO snippets; Expo eas.json/app.config.ts; 15 new doc templates
- Installer: --mobile flag; working copies of all docs at their final paths
### Changed
- Stack per project type (Next.js site+admin in one project; Expo; Node.js or Python engines); Railway-first via GitHub only
- Only `develop` exists locally; partial vs full test levels; required checks per branch in setup-github.sh
- Rule 02 is now backend (NestJS + FastAPI); rule 10-marketing-landing split into 10/14/15
- AI: one customer-service agent per system on an expandable agents service; WhatsApp lead generation, warming and assignment

## [1.0.0] — 2026-10-07
- Initial kit: 12 rules, 19 skills, templates, CI/CD, install and GitHub setup scripts
