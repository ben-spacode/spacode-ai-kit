// components/seo/JsonLd.tsx — render structured data. Validate with Google's Rich Results Test.
type Json = Record<string, unknown>;

export function JsonLd({ data }: { data: Json | Json[] }) {
  return <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(data).replace(/</g, '\\u003c') }} />;
}

const SITE_URL = process.env.NEXT_PUBLIC_SITE_URL!;

export const organizationLd = (o: { name: string; logo: string; phone?: string; sameAs?: string[] }) => ({
  '@context': 'https://schema.org',
  '@type': 'Organization',
  name: o.name,
  url: SITE_URL,
  logo: o.logo,
  ...(o.phone && { contactPoint: { '@type': 'ContactPoint', telephone: o.phone, contactType: 'customer service', areaServed: 'IL', availableLanguage: ['he'] } }),
  sameAs: o.sameAs ?? [],
});

export const breadcrumbLd = (items: { name: string; path: string }[]) => ({
  '@context': 'https://schema.org',
  '@type': 'BreadcrumbList',
  itemListElement: items.map((it, i) => ({ '@type': 'ListItem', position: i + 1, name: it.name, item: `${SITE_URL}${it.path}` })),
});

export const articleLd = (a: { title: string; description: string; path: string; image: string; author: string; published: string; modified: string }) => ({
  '@context': 'https://schema.org',
  '@type': 'BlogPosting',
  headline: a.title,
  description: a.description,
  image: a.image,
  mainEntityOfPage: `${SITE_URL}${a.path}`,
  author: { '@type': 'Person', name: a.author },
  datePublished: a.published,
  dateModified: a.modified,
  inLanguage: 'he-IL',
});

export const faqLd = (faqs: { q: string; a: string }[]) => ({
  '@context': 'https://schema.org',
  '@type': 'FAQPage',
  mainEntity: faqs.map((f) => ({ '@type': 'Question', name: f.q, acceptedAnswer: { '@type': 'Answer', text: f.a } })),
});
