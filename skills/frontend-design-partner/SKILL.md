---
name: frontend-design-partner
description: Build, upgrade or audit front-end UI on any stack (Next.js, React, Vue, HTML/CSS, Tailwind, MUI…) so it looks designed rather than AI-generated — discovery of the existing system, design tokens, anti-"AI look" taste rules, component states, RTL, and a mandatory screenshot verification loop at 375/768/1440 plus an accessibility/UX checklist. Use for "עיצוב פרונט", "שפר UI", "תעצב לי מסך", "זה נראה AI", UI audit, visual QA.
---

# Frontend Design Partner

סקיל אחד שמחבר טעם, הנחיות עיצוב, מערכת עיצוב, קומפוננטות ובדיקה ויזואלית. עובד על כל סטאק ועל כל סוג מערכת: אתר תדמית, דף נחיתה, SaaS, דשבורד, CRM ומובייל-ווב.

**העיקרון:** קודם מבינים את המערכת הקיימת, אחר כך מקבעים שפה עיצובית, ורק אז בונים. ותמיד בודקים בעיניים (צילומי מסך) לפני שמכריזים "סיימתי".

**בפרויקט Spacode:** מקור הטוקנים הוא `docs/brand/tokens.json` ועיצוב ה-Stitch (`stitch-design`). הסקיל הזה הוא שכבת הטעם והבדיקה הוויזואלית, `apple-design` הוא שכבת התנועה והמגע, ו-`nextjs-feature` הוא שכבת המימוש.

## שלב 0: מה המשימה?
זהה מהבקשה, ואם לא ברור שאל שאלה אחת:
- **בנייה חדשה:** מסך, דף או קומפוננטה מאפס.
- **שדרוג קיים:** "זה נראה גרוע / נראה AI, תשפר".
- **ביקורת בלבד:** דוח ממצאים בלי לשנות קוד.

## שלב 1: Discovery (לא מדלגים)
- **סטאק:** `package.json`, framework, שיטת עיצוב (Tailwind, CSS Modules, SCSS, styled-components, MUI, Bootstrap).
- **מה כבר קיים:** קבצי theme/tokens, `tailwind.config`, משתני `:root`, `components/ui`, אייקונים ופונטים.
- **מיתוג:** `docs/brand/BRAND-GUIDE.md` ו-`tokens.json`. אם אין, שאל על צבע מותג אחד ותחושה (רציני, חם, טכנולוגי, יוקרתי, שובב), או הפעל את `brand-identity`.
- **כיוון:** עברית או ערבית → RTL מלא (`dir="rtl"`, logical properties). דו-לשוני → שני הכיוונים.
- **מכשיר עיקרי:** מובייל-first לאתרים ציבוריים, דסקטופ-first לרוב מערכות הניהול וה-CRM.
- אם יש רק URL חי: צלם בכמה רוחבים (Playwright או כלי דפדפן) ונתח משם.

## שלב 2: מערכת עיצוב (Design Tokens)
אם קיימת, משתמשים בה ולא ממציאים חדשה. אם אין או שהיא מבולגנת, יוצרים קובץ טוקנים אחד במקום שמתאים לסטאק (`tokens.css`, `theme.ts` או הרחבת `tailwind.config`), ומסנכרנים ל-`docs/brand/tokens.json`:
- **צבע:** מותג אחד עם סקאלה 50–900, ניטרלים עם גוון קל של המותג, וצבעי סטטוס (success, warning, danger, info). ניגודיות 4.5:1 לפחות (3:1 לטקסט גדול). מצב כהה מוגדר במפורש, לא בהיפוך אוטומטי.
- **טיפוגרפיה:** פונט אחד, לכל היותר שניים. לעברית: Heebo, Assistant, Rubik, Noto Sans Hebrew. סקאלה 12/14/16/18/24/30/36/48. line-height 1.5 לגוף ו-1.1–1.25 לכותרות.
- **ריווח:** בסיס 4px (4/8/12/16/24/32/48/64), בלי ערכים כמו 13px.
- **רדיוס:** 2–3 ערכים. **צללים:** 2–3 רמות עדינות.
- **תנועה:** 150–250ms ease-out, או springs לפי `apple-design`. תמיד מכבדים `prefers-reduced-motion`.
- **Breakpoints:** 375 / 768 / 1024 / 1440.

## שלב 3: כללי טעם (Anti "AI-look")
**להימנע:**
- ✗ גרדיאנט סגול-כחול דיפולטיבי ו-glow בכל מקום.
- ✗ אימוג'י במקום אייקונים.
- ✗ הכול ממורכז, וכרטיסים זהים בשורות אינסופיות.
- ✗ Lorem או "Welcome to our platform".

**לאכוף:**
- ✓ היררכיה ברורה: דבר אחד חשוב בכל מסך. גודל ומשקל לפני צבע.
- ✓ צבע אקסנט אחד לפעולות ראשיות, וכל השאר ניטרלי.
- ✓ מרווח לבן נדיב, וקרבה בין אלמנטים שקשורים זה לזה.
- ✓ יישור לגריד, ושורת טקסט באורך 60–75 תווים.
- ✓ סט אייקונים אחד (Lucide, Heroicons, Phosphor) בגודל ובעובי קו אחידים.
- ✓ תוכן שנראה אמיתי: מספרים, שמות ותמונות כמו במוצר עצמו.
- ✓ כפתור primary אחד בכל אזור, ו-secondary או ghost לשאר.
- ✓ **CRM ומערכות ניהול:** צפיפות מידע נכונה, טבלאות קריאות (מספרים מיושרים, zebra עדין או קווים), פילטרים גלויים, פעולות מרוכזות.
- ✓ **דפי נחיתה:** Hero עם הבטחה אחת ברורה, הוכחה חברתית אמיתית, ו-CTA שחוזר (לפי `15-landing-branding` ו-`copywriting`).

## שלב 4: קומפוננטות
סדר העדיפויות:
1. קומפוננטות שכבר קיימות בפרויקט.
2. הספרייה שהפרויקט כבר משתמש בה (shadcn/ui, MUI וכו').
3. ספרייה חיצונית חדשה, רק אחרי `dependency-vetting` ואישור המשתמש.

כל קומפוננטה אינטראקטיבית צריכה את כל המצבים: default, hover, focus-visible, active, disabled, loading. כל מסך נתונים צריך loading (skeleton), empty (עם הסבר ופעולה) ו-error (עם דרך להתאושש).

## שלב 5: בנייה
- רק טוקנים: בלי צבעים או מרווחים hardcoded.
- HTML סמנטי: `button` לפעולה, `a` לניווט, `label` לכל שדה, כותרות בסדר היררכי.
- RTL: `margin-inline-start`, `text-align: start`, אייקוני חיצים שמתהפכים.
- תמונות: width/height או aspect-ratio, `loading="lazy"` מתחת לקפל, ו-alt משמעותי (או `next/image`).

## שלב 6: לולאת אימות ויזואלי (חובה)
אחרי כל שינוי משמעותי:
1. הרץ את ה-dev server.
2. צלם ב-375, 768 ו-1440 (גם במצב כהה וב-RTL אם רלוונטי):
```js
// scripts/shots.mjs — node scripts/shots.mjs http://localhost:3000
import { chromium } from 'playwright';
import { mkdirSync } from 'node:fs';
const url = process.argv[2];
mkdirSync('shots', { recursive: true });
const browser = await chromium.launch();
for (const w of [375, 768, 1440]) {
  const page = await browser.newPage({ viewport: { width: w, height: 900 }, locale: 'he-IL' });
  const errors = [];
  page.on('console', m => m.type() === 'error' && errors.push(m.text()));
  await page.goto(url, { waitUntil: 'networkidle' });
  await page.screenshot({ path: `shots/${w}.png`, fullPage: true });
  if (errors.length) console.log(w, errors);
}
await browser.close();
```
3. הסתכל על הצילומים בעצמך: גלישה אופקית, טקסט חתוך, יישור שבור, ריווח לא עקבי, ניגודיות, היררכיה ושגיאות קונסול.
4. תקן וצלם שוב, עד 3 סבבים. אם עדיין יש בעיה, דווח עליה במפורש.

`shots/` לא נכנס ל-git. צילומים קבועים להשוואה שייכים לבדיקות ה-visual regression של Playwright (`full-test-suite`).

## שלב 7: ביקורת איכות (Checklist)
- **נגישות** (WCAG 2.1 AA / ת"י 5568): ניגודיות, focus גלוי, ניווט מקלדת מלא, labels, alt, `aria-*` רק כשאין אלמנט סמנטי, יעדי מגע של 44×44px, אין מידע שמועבר רק בצבע, reduced-motion.
- **UX:** מצבי loading, empty ו-error. ולידציה ליד השדה ובזמן הנכון, הודעות שגיאה אנושיות, אישור לפני פעולות הרסניות, ומשוב אחרי כל פעולה.
- **ביצועים:** אין CLS, `font-display: swap`, תמונות בפורמט מודרני. היעד: Lighthouse מעל 90.
- **עקביות:** אין ערכים מחוץ לטוקנים, אייקונים מסט אחד, רדיוסים אחידים.

## פלט
בעברית ובקצרה:
- מה נבנה או שונה (קבצים עיקריים).
- טוקנים שנקבעו או נמצאו.
- צילומי לפני/אחרי (בשדרוג).
- ממצאים פתוחים לפי חומרה: קריטי, חשוב, שיפור.

במצב ביקורת בלבד: רק דוח ממצאים לפי חומרה, עם הצעת תיקון קונקרטית לכל ממצא, בלי לגעת בקוד.

## כללים
- לא מתקינים חבילות, סקילים או MCP חיצוניים בלי אישור מפורש.
- לא משנים את המיתוג (לוגו, צבע מותג) בלי לשאול.
- לא מעתיקים עיצוב של מותג אחר אחד לאחד: לוקחים עקרונות, לא נכסים.
- שינוי עיצובי גדול במערכת קיימת: מציגים קודם תוכנית קצרה ומחכים לאישור. השינוי עצמו עובר PR ל-develop.
