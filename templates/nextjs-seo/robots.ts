// app/robots.ts — production indexable, every other environment blocked.
import type { MetadataRoute } from 'next';

const SITE_URL = process.env.NEXT_PUBLIC_SITE_URL!;
const isProd = process.env.APP_ENV === 'production';

export default function robots(): MetadataRoute.Robots {
  if (!isProd) {
    return { rules: [{ userAgent: '*', disallow: '/' }] };
  }
  return {
    rules: [{ userAgent: '*', allow: '/', disallow: ['/admin', '/api', '/auth', '/thank-you'] }],
    sitemap: `${SITE_URL}/sitemap.xml`,
    host: SITE_URL,
  };
}
