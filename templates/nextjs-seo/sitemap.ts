// app/sitemap.ts — static routes + dynamic content. Never include admin/private/noindex pages.
import type { MetadataRoute } from 'next';
// import { getPublishedArticles, getPublishedLandingPages } from '@/lib/content';

const SITE_URL = process.env.NEXT_PUBLIC_SITE_URL!;

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const now = new Date();
  const staticRoutes = ['', '/about', '/services', '/blog', '/contact', '/accessibility', '/privacy'].map((p) => ({
    url: `${SITE_URL}${p}`,
    lastModified: now,
  }));

  // const articles = (await getPublishedArticles()).map((a) => ({ url: `${SITE_URL}/blog/${a.slug}`, lastModified: a.updatedAt }));
  // const landings = (await getPublishedLandingPages({ indexable: true })).map((l) => ({ url: `${SITE_URL}/lp/${l.slug}`, lastModified: l.updatedAt }));

  return [...staticRoutes /*, ...articles, ...landings */];
}
// For > ~45,000 URLs use generateSitemaps() to split into multiple sitemaps.
