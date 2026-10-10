// apps/mobile/app.config.ts — variants per environment so dev/staging/prod install side by side.
import type { ExpoConfig } from 'expo/config';

const VARIANT = (process.env.APP_VARIANT ?? 'development') as 'development' | 'preview' | 'production';
const BASE_ID = 'il.co.spacode.REPLACE'; // confirm permanent production identifiers with the CTO before first build

const byVariant = {
  development: { suffix: '.dev', name: ' (Dev)', api: 'https://api.dev.REPLACE' },
  preview: { suffix: '.staging', name: ' (Staging)', api: 'https://api.staging.REPLACE' },
  production: { suffix: '', name: '', api: 'https://api.REPLACE' },
}[VARIANT];

const config: ExpoConfig = {
  name: `REPLACE_APP_NAME${byVariant.name}`,
  slug: 'REPLACE-slug',
  scheme: 'replace-scheme',
  version: '1.0.0',
  orientation: 'portrait',
  ios: { bundleIdentifier: `${BASE_ID}${byVariant.suffix}`, supportsTablet: false },
  android: { package: `${BASE_ID}${byVariant.suffix}` },
  runtimeVersion: { policy: 'appVersion' },
  plugins: ['expo-router', 'expo-localization', 'expo-secure-store'],
  extra: { apiUrl: byVariant.api, variant: VARIANT, eas: { projectId: 'REPLACE_EAS_PROJECT_ID' } },
};

export default config;
