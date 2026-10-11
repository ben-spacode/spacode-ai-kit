---
name: growth-engine
description: Unified marketing and growth workflow that chains the Spacode marketing, SEO and design skills in the right order — site architecture, brand, competitor gaps, copywriting with marketing psychology, Apple-quality design and motion, content at scale, landing pages, paid ads, WhatsApp leads, social reels and CTR optimization — and tells you which skill to run next. Use for "תוכנית צמיחה", "קידום מלא לאתר", "מאיפה להתחיל בשיווק", growth plan, full marketing setup, or when unsure which marketing skill fits.
---

# Growth Engine: איחוד סקילי השיווק, ה-SEO והעיצוב

הסקיל הזה לא מחליף את הסקילים האחרים. הוא קובע **את הסדר**, מעביר תוצרים מסקיל לסקיל, ומונע עבודה כפולה. כל שלב קורא את התוצרים של השלבים הקודמים מ-`docs/` לפני שהוא שואל שאלות.

## מפת הסקילים
| שכבה | סקיל | תוצר עיקרי |
|---|---|---|
| אסטרטגיה | `brand-identity` | `docs/brand/BRAND-GUIDE.md`, `tokens.json` |
| | `marketing-psychology` | מנופים פסיכולוגיים מתאימים לקהל (אתיים) |
| מבנה | `site-architecture` | היררכיית עמודים, ניווט, URLs, קישורים פנימיים |
| מחקר | `competitor-content-gap` | בריף עמוד שעוקף את המתחרה |
| | `content-engine` | `keyword-map.csv`, אשכולות, תוכנית תוכן |
| מילים | `copywriting` | קופי לעמודים, כותרות, CTA (בלי "AI tells") |
| עיצוב | `site-to-stitch` | ייבוא אתר רפרנס או מערכת קיימת למסכים ב-Stitch |
| | `stitch-design` | מסכים מ-Stitch שמותאמים לטוקנים ונמשכים לקוד |
| | `frontend-design-partner` | טעם (בלי "מראה AI"), טוקנים, ובדיקה ויזואלית ב-375/768/1440 |
| | `apple-design` | תנועה, מגע, חומרים וטיפוגרפיה ברמת Apple (web) |
| | `mobile-native` | תחושה נייטיב לאתר במובייל |
| | `animate-expo` | אנימציות ומחוות באפליקציית Expo |
| תשתית | `seo-foundation` | sitemap, robots, metadata, schema, פיקסלים |
| המרה | `landing-campaign` | דף נחיתה, טופס ליד ל-CRM |
| | `whatsapp-lead-engine` | לידים, חימום, שיוך לפי קבוצה ומקור |
| ממומן | `paid-ads-appendix` | `PAID-ADS-APPENDIX.md` |
| רשתות | `universal-reel-analyzer` | ניתוח רילס מכל פלטפורמה ותסריטים מקוריים |
| ניתוח | `web-page-analyzer` | ניתוח כל דף, אתר, מערכת, מודעה או חנות, ומה לקחת ממנו |
| אופטימיזציה | `gsc-ctr-optimizer` | כותרות ו-Meta לעמודים עם CTR נמוך |

## זרימה לאתר או מוצר חדש
1. **יסודות:** `brand-identity` עם `marketing-psychology` (פרסונות, מסרים ומנופים מתאימים). מתחילים מהמיתוג, כי כל השאר נשען עליו.
2. **מבנה:** `site-architecture` קובע אילו עמודים צריך, ניווט ו-URLs, ומעדכן את רשימת המסכים ב-`docs/design/DESIGN-BRIEF.md`.
3. **מחקר:** `content-engine` (מפת מילות מפתח ואשכולות), ואז `competitor-content-gap` על 3–5 מילות המפתח החשובות ביותר.
4. **מילים:** `copywriting` לעמודי הליבה (בית, שירותים, מחירים, נחיתה), כשה-Hooks וה-CTA מגיעים מ-`marketing-psychology`.
5. **עיצוב:** `web-page-analyzer` על אתרי הרפרנס, ואז `site-to-stitch` כדי לייבא את הרפרנס ל-Stitch. משם `stitch-design` (התאמה ומשיכה לקוד אחרי שהשלד מוכן), מעליו `apple-design` לתנועה ולמגע, `mobile-native` לאתר במובייל ו-`animate-expo` לאפליקציה. בסוף `frontend-design-partner` ללולאת בדיקה ויזואלית וביקורת איכות.
6. **תשתית:** `seo-foundation` (כבר בשלב השלד) ו-Lighthouse מעל 90.
7. **המרה:** `landing-campaign` לכל קמפיין, ו-`whatsapp-lead-engine` לכל לידי ה-WhatsApp.
8. **הפצה:** `content-engine` לפרסום מאמרים במנות עם שער איכות, `universal-reel-analyzer` לפורמטים שעובדים ברשתות, ו-`paid-ads-appendix` לממומן.
9. **אופטימיזציה (מחזורית):** כל חודש `gsc-ctr-optimizer`. כל רבעון `competitor-content-gap` על מילות מפתח שבהן ירדנו, וריענון מאמרים.

## זרימה לאתר קיים
`web-page-analyzer` (תמונת מצב של האתר) → `gsc-ctr-optimizer` (רווחים מהירים) → `competitor-content-gap` (עמודים בעמוד 2) → `site-architecture` (אם יש בעיות מבנה או קישורים פנימיים) → `copywriting` לשכתוב עמודים חלשים → `frontend-design-partner` (שדרוג UI ובדיקה ויזואלית), `apple-design` ו-`mobile-native` לשיפור חוויה. לעיצוב מחדש: `site-to-stitch` על האתר הקיים, ואחריו `stitch-design`.

## חוקים משותפים לכל השלבים
- **אמת בלבד:** בלי מספרים, המלצות או דחיפות מומצאים. פסיכולוגיה שיווקית רק בצורה אתית (בלי dark patterns).
- **תוכן מקורי:** מתחרים ורילס הם השראה ומידע, לא מקור להעתקה.
- **עברית טבעית ו-RTL**, טון הדיבור מהמיתוג, ונגישות לפי ת"י 5568.
- כל שינוי באתר עובר PR ל-develop, ומשם בזרימה הרגילה. פעולות חיצוניות (פרסום, Submit, תקציבים) רק באישור מפורש.
- **מדידה:** לכל שינוי יש תאריך ומדד (CTR, דירוג, CVR, CPL), ובדיקה חוזרת אחרי 2–4 שבועות.

## פלט כשמפעילים את הסקיל
1. תמונת מצב: אילו תוצרים כבר קיימים ב-`docs/` ומה חסר.
2. השלב הבא המומלץ והסקיל שמריצים, עם הסבר במשפט.
3. תוכנית ל-4 השבועות הקרובים: שבוע, סקיל, תוצר.
