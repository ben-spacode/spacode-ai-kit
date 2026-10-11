---
name: content-engine
description: Plan and produce keyword-driven content at scale (target 1,000+ articles over time) for a site or landing page — keyword research, topic clusters, keyword map, article briefs, drafting with quality gates, internal linking, publishing pipeline in Next.js (MDX or DB), refresh routine. Use for "מאמרים", "תוכן לקידום", "1000 מאמרים", content plan, blog, keyword map.
---

# Content Engine

Read `.cursor/rules/10-seo-organic.mdc`. Important: Google's spam policies target "scaled content abuse" — many
pages produced mainly to rank, with little value. Volume is reached **through a pipeline with quality gates**, not
by bulk-publishing raw AI text. Tell the user this when they ask for large batches.

## 1. Research → keyword map
- Inputs: business, services, audience, regions, competitors, seed keywords (from client + Search Console if exists).
- Expand: question keywords ("איך", "כמה עולה", "מה ההבדל"), commercial ("מחיר", "המלצות", "השוואה"), local, problem-aware.
- Get volumes/difficulty from a keyword tool the user has (Google Keyword Planner, Ahrefs, Semrush…) — never invent numbers; mark "unknown" if no tool.
- Classify intent (informational / commercial / transactional / navigational); cluster by shared intent.
- Write `docs/marketing/keyword-map.csv`: `keyword,intent,volume,difficulty,cluster,pillar,target_slug,priority,status`.

## 2. Architecture
Align clusters with the page hierarchy and internal-linking plan from `site-architecture`. For priority keywords where a competitor dominates, run `competitor-content-gap` first.
- Pillar page per cluster (comprehensive guide) + 10–40 cluster articles linking up to the pillar and sideways.
- Plan the 1,000 as: N clusters × M articles, prioritized by business value × opportunity. Record in `docs/marketing/CONTENT-PLAN.md` with batches and cadence.

## 3. Brief per article (`content/briefs/<slug>.md`)
Primary keyword + intent, secondary keywords, target reader, angle/unique value (data, experience, examples),
outline H2/H3, questions to answer, internal links (pillar + 2–5), CTA, schema type, sources to verify.

## 4. Draft (with `copywriting` — no AI tells) → quality gate (all must pass before publish)
- [ ] Answers the intent better than current top results; contains original value (example, data, expert insight, local context)
- [ ] Facts verified; sources cited where claims are made
- [ ] Natural Hebrew, proofread; no keyword stuffing
- [ ] Title ≤ 60, meta ≤ 155, one H1, descriptive headings, alt text
- [ ] Internal links added (and links *to* it from related articles)
- [ ] Author byline with real bio (E-E-A-T); updated date
- [ ] Human reviewer approved (name in front-matter `reviewedBy`)

## 5. Pipeline in the project
- Storage: MDX in `content/articles/` with front-matter, or `articles` table + admin editor (status: draft → review → scheduled → published).
- Pages `app/(site)/blog/[slug]` with `generateStaticParams`/ISR, `Article` + `BreadcrumbList` schema, related articles, CTA block.
- Auto-included in `sitemap.ts`; RSS feed optional.
- Scheduled publishing in batches; track indexing (Search Console) and rankings per keyword.

## 6. Refresh & measure
Monthly: run `gsc-ctr-optimizer` for high-impression/low-CTR pages; articles losing clicks → refresh; cannibalization check; merge thin articles; update keyword map statuses.
Report: indexed pages, impressions, clicks, top movers, leads from content.
