---
name: nextjs-feature
description: Build a Next.js frontend feature/screen to Spacode standards — Hebrew RTL, i18n strings, typed API client, forms with zod, loading/empty/error states, accessibility, responsive. Use when creating pages, screens, dashboards, forms or UI components ("תבנה מסך", "new page", "implement this Figma screen").
---

# Next.js Feature Builder

## Before writing
- Read `.cursor/rules/03-frontend-nextjs-rtl.mdc`.
- Look at existing pages/components and the design tokens; reuse `components/ui` primitives.
- If a Figma link is given and the Figma MCP is available, pull the design context first; adapt to the project's components and tokens — don't paste generated code as-is.

## Build steps
1. Route in `app/(dashboard)/<feature>/page.tsx` (server component) + `loading.tsx` + `error.tsx`.
2. Typed API functions in `lib/api/<feature>.ts` (shared types from `packages/shared` if present).
3. Components in `components/<feature>/`; client components only where needed.
4. Forms: React Hook Form + zod schema (shared with backend DTO if possible), inline Hebrew error messages, disabled submit while pending, server error mapping.
5. Strings → `messages/he.json` (and `en.json` if bilingual) under a `<feature>` namespace.
6. States: loading skeleton, empty state with CTA, error with retry, no-permission.
7. Permissions: hide/disable actions by role, but never rely on UI for security.

## RTL / a11y checklist
- [ ] Only logical spacing/positioning classes (`ms/me/ps/pe/start/end`)
- [ ] Directional icons flip; numbers/phones/emails isolated LTR
- [ ] Dates `he-IL` + `Asia/Jerusalem`; currency ILS
- [ ] Keyboard navigation + visible focus; labels on all inputs; contrast AA
- [ ] Works at 375px; tables become cards or scroll horizontally inside a container
- [ ] `data-testid` on key elements for Playwright

## Done
Add/adjust a Playwright test for the main flow. Report files changed and screenshots if possible.
