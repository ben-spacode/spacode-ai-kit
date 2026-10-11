---
name: brand-identity
description: Create or document a business brand for a Spacode project — positioning, value proposition, audience, Hebrew tone of voice, messaging pillars, naming/tagline, color palette with accessible contrast, typography, imagery, logo usage rules, and design tokens for code and Stitch. Use for "מיתוג", brand guide, brand identity, tone of voice, or before landing pages/design when no brand guide exists.
---

# Brand Identity

Output: `docs/brand/BRAND-GUIDE.md` + `docs/brand/tokens.json` (consumed by Tailwind/CSS variables and given to Stitch as context).

## 1. Strategy (ask/collect)
Business, category, target audiences (2–3 personas), competitors (3–5) and how they position, why customers choose
this business, proof points, price positioning, personality (3–5 adjectives), what the brand is **not**.

## 2. Write the guide
Use `marketing-psychology` to choose ethical persuasion levers per persona and `copywriting` for taglines and boilerplate.
1. **Positioning statement:** For <audience> who <need>, <brand> is the <category> that <key benefit>, unlike <alternative>, because <reason to believe>.
2. **Value proposition** (one line) + 3 **messaging pillars** with proof for each.
3. **Tone of voice in Hebrew:** register (את/אתה vs. רבים, formal vs. friendly), do/don't word list, example rewrites.
4. **Tagline options** (3–5) and boilerplate (25/50/100 words).
5. **Visual identity:**
   - Palette: primary, secondary, accent, neutrals, semantic (success/warning/error) — hex + usage %; every text/background pair meets WCAG AA (state the ratio).
   - Typography: Hebrew + Latin pairing (e.g. Heebo/Rubik/Assistant), scale, weights.
   - Logo usage: clear space, minimum size, backgrounds, don'ts (if a logo exists; designing a new logo is a designer task — provide a brief).
   - Imagery & iconography style, illustration rules, photography do/don't.
   - UI: radius, shadows, spacing scale, button styles.
6. **Applications:** website, landing pages, WhatsApp templates tone, social post templates, email signature.

## 3. Tokens
`tokens.json` (colors, fonts, spacing, radius, shadows) → map to Tailwind theme / CSS variables; pass to Stitch prompts.

## Rules
Original identity only — don't imitate another company's brand. Accessibility of colors is mandatory.
