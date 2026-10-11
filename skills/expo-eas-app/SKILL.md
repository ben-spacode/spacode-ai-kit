---
name: expo-eas-app
description: Create or extend a mobile app with Expo (React Native, TypeScript, Expo Router) and ship it to Android and iOS with EAS Build, Submit and Update — app variants per environment, eas.json profiles mapped to develop/staging/main, GitHub-triggered builds, store compliance and Maestro E2E. Use for "אפליקציה", mobile app, Expo, EAS, App Store, Google Play.
---

# Expo + EAS App

Read `.cursor/rules/12-mobile-expo.mdc`. Check current Expo/EAS docs for exact CLI flags when unsure — they change between SDKs.

## 1. Create
- `npx create-expo-app@latest apps/mobile` (TypeScript template) — version chosen per `dependency-vetting`.
- Expo Router, i18n (`expo-localization` + i18next), RTL setup, React Query, zod, `expo-secure-store`, Sentry.
- API client to the server engine (Node.js/NestJS or Python/FastAPI); shared types/schemas in `packages/shared`.

## 2. Variants (`app.config.ts`)
`APP_VARIANT` = development | preview | production → name suffix (Dev/Staging), bundle id/package suffix, icon badge,
`extra.apiUrl`, EAS Update channel. Production identifiers are permanent — confirm them with the CTO before first build.

## 3. eas.json
Template in `docs/templates/mobile/eas.json` (+ `app.config.ts`): profiles `development` (dev client, internal), `preview` (internal, staging API),
`production` (store, `autoIncrement`), `cli.appVersionSource: "remote"`, channels development/staging/production,
`submit.production` for iOS (ASC app id) and Android (service account key path from EAS secrets, track internal → production).

## 4. CI (template `.github/workflows/eas.yml`)
- PR → develop: lint, typecheck, Jest, `expo-doctor` (partial).
- develop: `eas build --profile preview` (or `eas update --channel development` for JS-only changes).
- staging: preview builds for both platforms → internal testing (TestFlight / Play internal) + Maestro E2E.
- main: `eas build --profile production` + `eas submit` (requires GitHub Environment approval) or `eas update --channel production` for compatible JS fixes.
Secrets: `EXPO_TOKEN` in GitHub; store credentials managed by EAS.

## 5. Store readiness checklist
Privacy policy, Apple privacy labels, Google Data Safety, in-app account deletion, permission strings (Hebrew),
ATT if tracking, screenshots/sizes, reviewer test account, content rating, support URL. Human submits/approves releases.

## 5b. Design & motion
UI feel per `apple-design` principles; animations, gestures, sheets and haptics per `animate-expo` (Reanimated + Gesture Handler, UI thread, springs).

## 6. Tests
Jest + RNTL for components/hooks; Maestro flows in `apps/mobile/.maestro/` for login and core journeys; real-device check iOS + Android before `main`.
