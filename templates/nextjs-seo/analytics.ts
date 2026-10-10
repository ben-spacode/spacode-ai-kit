// lib/analytics/index.ts — one track() for GA4, Meta Pixel and Google Ads, plus server-side CAPI via /api/track.
// IDs come from env. No-op outside production unless NEXT_PUBLIC_TRACKING_TEST_MODE=1. Respect consent.
'use client';

type EventName = 'page_view' | 'generate_lead' | 'contact' | 'sign_up' | 'purchase' | 'view_content';
type Params = Record<string, string | number | undefined> & { value?: number; currency?: string };

const META_MAP: Record<EventName, string> = {
  page_view: 'PageView', generate_lead: 'Lead', contact: 'Contact', sign_up: 'CompleteRegistration', purchase: 'Purchase', view_content: 'ViewContent',
};

const enabled = () =>
  typeof window !== 'undefined' &&
  (process.env.NEXT_PUBLIC_APP_ENV === 'production' || process.env.NEXT_PUBLIC_TRACKING_TEST_MODE === '1') &&
  (window as any).__consent?.marketing !== false;

export function track(event: EventName, params: Params = {}, user?: { email?: string; phone?: string }) {
  if (!enabled()) return;
  const eventId = crypto.randomUUID(); // shared with CAPI for deduplication
  const w = window as any;
  w.gtag?.('event', event, { ...params, event_id: eventId });
  w.fbq?.('track', META_MAP[event], params, { eventID: eventId });
  if (event === 'generate_lead' && process.env.NEXT_PUBLIC_GADS_LEAD_LABEL) {
    w.gtag?.('event', 'conversion', { send_to: process.env.NEXT_PUBLIC_GADS_LEAD_LABEL, value: params.value, currency: params.currency ?? 'ILS' });
  }
  // Server side: Meta CAPI (+ Google Ads enhanced conversions) — hashing happens on the server, never in the browser.
  navigator.sendBeacon?.('/api/track', JSON.stringify({ event, eventId, params, user, url: location.href }));
}
