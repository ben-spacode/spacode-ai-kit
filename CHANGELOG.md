# Changelog — Spacode AI Kit

## [2.4.0] — 2026-10-11
### Added
- web-page-analyzer — analyze any page/site/system/store/ad/post and what to take from it
- frontend-design-partner — taste rules, tokens, component states, screenshot verification loop, UI audit
- universal-reel-analyzer — any platform, any business profile (replaces social-reel-analyzer)
- site-to-stitch — website/system → Google Stitch screens via the Stitch MCP (adapted from a Figma-based skill)
### Changed
- stitch-design lists the Stitch MCP tools and starts optionally from site-to-stitch; growth-engine, rules 03/16 and
  nextjs-feature include the new skills
### Removed
- social-reel-analyzer (merged into universal-reel-analyzer)

## [2.3.0] — 2026-10-11
### Added
- Vendored skills (MIT): copywriting, site-architecture, marketing-psychology (coreyhaines31/marketingskills);
  apple-design, animate-expo, mobile-native (emilkowalski/skills) — with Spacode adapters, LICENSE and SOURCE.txt each
- vendor/skills.json, vendor/adapters/, scripts/update-vendored-skills.sh, THIRD_PARTY_NOTICES.md
- Skills: gsc-ctr-optimizer, social-reel-analyzer, competitor-content-gap (adapted for Cursor and the Spacode flow)
- growth-engine: one workflow that orders and connects all marketing, SEO and design skills
### Changed
- landing-campaign, content-engine, seo-foundation, brand-identity, stitch-design, expo-eas-app, nextjs-feature,
  project-kickoff and rules 10/12/15/16 now reference the new skills

## [2.2.0] — 2026-10-11
### Added
- AWS as a full hosting option: `pipeline.yml` AWS mode (OIDC → ECR → migration ECS task → task-definition revisions → update-service → wait stable)
- `infra-aws.yml`: Terraform plan on PR (+ IaC security scan), apply after merge per environment
- `--hosting railway|aws` in install-spacode-kit.sh, setup-github.sh and AI-INSTALL.md; repository variable HOSTING
### Changed
- Rules 00/09, AGENTS.md, ADR-0001, project-kickoff and deploy-aws describe Railway-or-AWS with the same GitHub-only principle
- version.json is also written to apps/web/public so Next.js serves it

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
