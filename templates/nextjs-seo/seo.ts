// lib/seo.ts — one helper for every page's metadata.
import type { Metadata } from 'next';

const SITE_URL = process.env.NEXT_PUBLIC_SITE_URL!;
const SITE_NAME = process.env.NEXT_PUBLIC_SITE_NAME ?? 'Site';
const isProd = process.env.APP_ENV === 'production';

type SeoInput = { title: string; description: string; path: string; image?: string; noindex?: boolean; type?: 'website' | 'article' };

export function buildMetadata({ title, description, path, image, noindex, type = 'website' }: SeoInput): Metadata {
  const url = new URL(path, SITE_URL).toString();
  const index = isProd && !noindex;
  return {
    metadataBase: new URL(SITE_URL),
    title,
    description,
    alternates: { canonical: url },
    robots: { index, follow: index },
    openGraph: { title, description, url, siteName: SITE_NAME, locale: 'he_IL', type, images: image ? [{ url: image }] : undefined },
    twitter: { card: 'summary_large_image', title, description, images: image ? [image] : undefined },
  };
}
// Root layout: export const metadata = { title: { default: SITE_NAME, template: `%s | ${SITE_NAME}` }, ... }
// Admin layout: export const metadata = { robots: { index: false, follow: false } }
