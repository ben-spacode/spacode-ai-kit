---
name: stitch-design
description: Run the Spacode design workflow with Google Stitch through its MCP server in Cursor — verify MCP setup, write the design brief from a chosen reference site and the brand guide, generate screens in Stitch, then after the skeleton is ready pull the screens via MCP and adapt them to the project's tokens, components, RTL and accessibility. Use for "עיצוב", "Stitch", design from a reference site, new screens, redesign.
---

# Stitch Design Workflow

Read `.cursor/rules/16-design-stitch.mdc`. Tool names exposed by the Stitch MCP can change — list the available
Stitch tools first and use what is actually there; don't assume tool names.

## 0. Check MCP
- `.cursor/mcp.json` contains the `stitch` server (`https://stitch.googleapis.com/mcp`, header `X-Goog-Api-Key: ${env:STITCH_API_KEY}`).
- `STITCH_API_KEY` is set in the developer's environment (not in the repo). Server shows connected in Cursor Settings → MCP.
- If not connected: stop, show the user the setup steps, don't hand-design as a substitute.

## 1. Design brief (`docs/design/DESIGN-BRIEF.md`)
- Reference site URL(s) chosen by the client/CTO; what to adopt (layout rhythm, hero style, navigation, card style, density, motion) and what to avoid.
- Brand guide tokens (colors, fonts, radius) and tone.
- Screen list by area: site (home, service, article, landing), admin (dashboard, list, detail, form, settings), mobile (if app).
- Constraints: Hebrew RTL, IS 5568 accessibility, mobile-first.
Inspiration only — no copying of logos, imagery, copy or distinctive trade dress of the reference.

## 1b. Import a reference (optional)
To start from an existing site or system (the client's current site, a chosen reference, or an internal app), run `site-to-stitch` first: it extracts tokens and structure and creates the screens in Stitch. Then continue here.

## 2. Generate in Stitch (via MCP)
Documented Stitch MCP tools (verify against the live list): `create_project`, `get_project`, `list_projects`, `list_screens`, `get_screen`, `generate_screen_from_text` (prompt + deviceType), `edit_screens`, `generate_variants`. Keep screen IDs from tool responses — `list_screens` may return empty until the project is opened in the browser. Create a Stitch project named `<client>-<product>`; generate each screen with a prompt built from the brief
(include: RTL Hebrew, brand colors/fonts, component style, content outline). Iterate variants; get CTO choice.
Record project id + screen ids in the brief.

## 3. Wait for the skeleton
Pull designs only when routes, layouts, auth, `components/ui` primitives and tokens exist (Phase 4 of kickoff).

## 4. Pull & adapt
For each screen: fetch code/assets via MCP → extract tokens and compare with `tokens.json` (update tokens deliberately,
not per screen) → rebuild using project components (no generated one-off markup) → logical RTL properties → strings to
`messages/he.json` → add loading/empty/error states, `data-testid`, a11y attributes → images via `next/image` in `public/` or storage.

## 4b. Motion & feel
Apply `apple-design` (springs, interruptible transitions, instant press feedback, materials, typography detail) and `mobile-native` for web on phones; `animate-expo` for Expo screens. Always respect reduced motion.

## 5. Review
Run the `frontend-design-partner` screenshot loop (375/768/1440) and checklist; side-by-side check vs Stitch screen at desktop and 375px, axe check, Lighthouse, CTO approval. Note deviations in the brief.
