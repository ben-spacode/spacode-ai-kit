import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';

// Key public pages — extend per project.
const PAGES = ['/'];

for (const path of PAGES) {
  test(`@smoke ${path} loads, is accessible and SEO-ready`, async ({ page }) => {
    const res = await page.goto(path);
    expect(res?.status()).toBeLessThan(400);
    await expect(page.locator('html')).toHaveAttribute('dir', 'rtl');
    await expect(page.locator('h1')).toHaveCount(1);
    expect(await page.title()).not.toEqual('');
    await expect(page.locator('meta[name="description"]')).toHaveAttribute('content', /.+/);
    await expect(page.locator('link[rel="canonical"]')).toHaveCount(1);

    const axe = await new AxeBuilder({ page }).withTags(['wcag2a', 'wcag2aa', 'wcag21aa']).analyze();
    const serious = axe.violations.filter((v) => v.impact === 'serious' || v.impact === 'critical');
    expect(serious, JSON.stringify(serious.map((v) => v.id))).toEqual([]);
  });

  test(`${path} visual`, async ({ page }) => {
    await page.goto(path);
    await expect(page).toHaveScreenshot({ fullPage: true });
  });
}

test('robots.txt and sitemap.xml exist', async ({ request, baseURL }) => {
  const robots = await request.get('/robots.txt');
  expect(robots.ok()).toBeTruthy();
  const sitemap = await request.get('/sitemap.xml');
  expect(sitemap.ok()).toBeTruthy();
  const isProd = process.env.APP_ENV === 'production';
  const body = await robots.text();
  if (!isProd) expect(body).toMatch(/Disallow:\s*\/\s*$/m); // non-production must not be indexed
  expect(baseURL).toBeTruthy();
});
