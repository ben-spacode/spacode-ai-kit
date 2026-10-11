---
name: seo-foundation
description: Implement the organic-promotion infrastructure in a Next.js project — sitemap.ts, robots.ts per environment, metadata and canonical helpers, JSON-LD structured data, OG images, analytics + pixels module (GA4, GTM, Meta Pixel + CAPI, Google Ads), Search Console readiness, Lighthouse CI. Use when setting up a website/landing page/blog, or for "SEO", "קידום אורגני", "מפת אתר", "robots", "פיקסל", "Search Console".
---

# SEO Foundation (Next.js)

Read `.cursor/rules/10-seo-organic.mdc` first. Templates are in the kit under `templates/nextjs-seo/` (installed to `docs/templates/nextjs-seo/`).

## Steps
0. Page hierarchy, URL patterns and navigation come from `site-architecture` (run it first for new sites).
1. **Env config:** `NEXT_PUBLIC_SITE_URL`, `APP_ENV`, analytics IDs. `metadataBase = new URL(SITE_URL)`.
2. **robots.ts:** production → allow `/`, disallow `/admin`, `/api`, `/auth`, thank-you pages; `sitemap: SITE_URL/sitemap.xml`.
   Other environments → `disallow: '/'`. Also add `X-Robots-Tag: noindex, nofollow` header in middleware/`next.config` outside production.
3. **sitemap.ts:** static routes + dynamic (articles, landing pages, services) from DB/content with `lastModified`;
   use `generateSitemaps` to split above ~45k URLs. Never include admin/private/noindex pages.
4. **Metadata helper** `lib/seo.ts` → `buildMetadata({ title, description, path, image, noindex })` returning
   title template, description, canonical, OG, Twitter, robots. Every page uses it; admin layout sets `robots: { index: false }`.
5. **Structured data** `components/seo/JsonLd.tsx` + builders: Organization/LocalBusiness (with `sameAs`), WebSite,
   BreadcrumbList, Article, FAQPage, Service/Product/SoftwareApplication. Render via `<script type="application/ld+json">`.
6. **OG images:** `opengraph-image.tsx` default + per article/landing; Hebrew font loaded.
7. **Analytics module** `lib/analytics/` — `track(event, params)` fans out to GA4 (gtag/GTM), Meta Pixel and Google Ads
   in the browser, and posts to `/api/track` which sends **Meta CAPI** (hashed email/phone, `event_id` shared for dedup) and
   Google Ads enhanced conversions server-side. Consent-aware; no-op outside production (or test-event mode).
8. **Performance:** `next/image`, `next/font`, no render-blocking third parties (load pixels `afterInteractive`/`lazyOnload`), preconnect where needed.
9. **Lighthouse CI:** `lighthouserc.json` with assertions ≥ 0.9 for performance, accessibility, best-practices, seo on key URLs; runs in the full test level.
10. **Launch checklist (human):** Search Console domain verification (DNS TXT), submit sitemap, Bing Webmaster, GA4 property per prod,
    Meta Pixel + CAPI test events verified, Google Ads conversion verified, Rich Results Test on key templates, 301 map if replacing a site.

## Verify
`curl` robots.txt and sitemap.xml on each environment, validate JSON-LD, run Lighthouse locally, confirm no noindex in production and noindex everywhere else.
