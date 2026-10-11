## Spacode adapter (read first)
This skill is vendored from an external MIT-licensed repository (see `THIRD_PARTY_NOTICES.md` in the Spacode kit). In Spacode projects:
- **Skip the "Initial Response" greeting** below when the skill is used as part of a task — go straight to the work.
- **Tokens first:** take colors, typography, radius and spacing from `docs/brand/tokens.json` / the project design tokens and the Stitch design (`stitch-design`); apply this skill to motion, interaction, materials and typographic detail — not to replace the brand.
- **Hebrew RTL:** mirror directional motion and gestures (swipe-to-go-back, drawers, carousels, chevrons) for RTL; use logical properties (`inset-inline-start`, `marginStart`). Respect `prefers-reduced-motion` / Reduce Motion always.
- **Where it applies:** websites and landing pages in Next.js (`apple-design`, `mobile-native`), Expo apps (`animate-expo` + `apple-design` principles). Check performance budgets (Lighthouse ≥ 90, INP < 200ms) after adding motion.
- Install packages only after `dependency-vetting`; in Expo use `npx expo install`.
