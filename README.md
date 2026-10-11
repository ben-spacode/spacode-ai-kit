# Spacode AI Kit v2 🧰

ערכת החוקים, הכללים והסקילים של Spacode לכל פרויקט חדש ב-Cursor. היא מכסה פיתוח, בדיקות, פריסה, קידום אורגני
וממומן, מיתוג, עיצוב ב-Stitch, סוכני AI, WhatsApp, ומסמכי מוצר ועסקים, ומותקנת בפקודה אחת.

## מבנה
```
spacode-ai-kit/
├── rules/        18 קבצי .mdc   → .cursor/rules/      (כל כלל בקובץ נפרד)
├── skills/       47 סקילים      → .cursor/skills/ + .claude/skills/  (כל סקיל = תיקייה עם SKILL.md)
├── templates/
│   ├── AGENTS.md · CLAUDE.md · CHANGELOG.md
│   ├── cursor/mcp.json           Stitch MCP (המפתח נקרא ממשתנה סביבה)
│   ├── docs/                     20 תבניות: PRD, ERD, ADR, בדיקות, מיתוג, עיצוב, נספח ממומן, תוכן, POC, MVP, מודל עסקי, תחזית, מצגת, דוחות
│   ├── github/                   ci-partial · pipeline (מלא + פריסה ל-Railway) · promotion · codeql · eas · תבניות PR/Issues · Dependabot
│   ├── root/                     .env.example · Playwright · Lighthouse CI · k6 · ZAP · docker-compose · lint configs
│   ├── nextjs-seo/               robots.ts · sitemap.ts · seo.ts · JsonLd.tsx · analytics.ts
│   └── mobile/                   eas.json · app.config.ts
├── vendor/       skills.json + adapters/  (סקילים חיצוניים והתאמות Spacode)
└── scripts/  install-spacode-kit.sh · setup-github.sh · bootstrap.sh · update-vendored-skills.sh
```

**חוקים וכללים:** אין להם פורמט נפרד ב-Cursor. ההבדל הוא באופן הטעינה:
- **חוקים** = כללים עם `alwaysApply: true`, שנטענים בכל בקשה: `00-core`, `01-git`, `05-security`, `06-testing`.
- **כללים** = כללים שנטענים לפי סוג הקובץ או לפי ההקשר.
- **סקילים** = תהליכי עבודה רב-שלביים שמופעלים לפי הצורך.

## כיסוי מסמך הדרישות
| דרישה | איפה זה מיושם |
|---|---|
| כל כלל או סקיל בקובץ md נפרד, עבור Cursor | `rules/*.mdc`, `skills/*/SKILL.md` |
| ענפים develop / staging / main; במחשב רק develop; ענפי עבודה לפני develop | כלל 01, `setup-github.sh` |
| staging מדמה פרודקשן; main בלי באגים | כללים 01 ו-06, שערי `pipeline.yml` |
| בדיקות חלקיות לפני develop, ומלאות מ-develop ומעלה (E2E, פונקציונליות ולא פונקציונליות) | כלל 06, `ci-partial.yml`, `pipeline.yml`, `promotion.yml`, סקיל `full-test-suite` |
| בדיקות אדומות חוסמות מיזוג | הגנת ענפים עם required checks ב-`setup-github.sh` |
| Railway, ועדכון רק דרך GitHub | כלל 09, `pipeline.yml`, סקיל `deploy-railway` |
| AWS כאפשרות מלאה, גם כן רק דרך GitHub | כלל 09, `pipeline.yml` (`HOSTING=aws`), `infra-aws.yml` (Terraform), סקיל `deploy-aws` |
| עדכון בסדר עולה בלבד | `promotion-guard` ב-`promotion.yml` |
| אפליקציה ב-Expo + EAS לאנדרואיד ולאפל; שרת Node.js או Python | כללים 12 ו-02, סקילים `expo-eas-app` ו-`python-service`, `eas.yml` |
| Next.js + PostgreSQL; סריקת פגיעויות לפני בחירת גרסה | כללים 00 ו-13, סקיל `dependency-vetting`, OSV ו-audit ב-CI |
| אתר ומערכת ניהול באותו פרויקט עם הפרדת תיקיות, ותשתית אורגנית בשניהם | כלל 03 (`app/(site)` + `app/(admin)`) |
| דפי נחיתה מקודמים בגוגל וברשתות, מיתוג ושיווק בדף | כללים 15, 10 ו-14, סקילים `landing-campaign` ו-`brand-identity` |
| 1000+ מאמרים עם מילות מפתח | כלל 10, סקיל `content-engine`, `keyword-map.csv`, `CONTENT-PLAN.md` |
| שירות נפרד ב-Railway לכל רכיב (אתר, נחיתה, מנוע, DB, Redis) | כלל 09, סקיל `deploy-railway` |
| סוכן AI לשירות לקוחות בכל מערכת, עם שרת סוכנים להרחבה; Claude או ChatGPT | כלל 08, סקיל `customer-service-agent` |
| WhatsApp רשמי דרך Meta: שירות, לידים, חימום, שיוך לפי קבוצה או מקור | כלל 07, סקילים `whatsapp-bot` ו-`whatsapp-lead-engine` |
| קידום אורגני: Search Console, פיקסלים, ציונים גבוהים, sitemap ו-robots | כלל 10, סקיל `seo-foundation`, `nextjs-seo/*`, Lighthouse CI |
| שיווק ממומן: תשתית, ידע, פעולות, ונספח לפרויקט | כלל 14, סקיל `paid-ads-appendix`, `PAID-ADS-APPENDIX.md` |
| עיצוב מ-Stitch דרך MCP שמוגדר ב-Cursor; אתר מקור → Stitch → משיכה אחרי שהשלד מוכן | כלל 16, סקיל `stitch-design`, `.cursor/mcp.json` |
| מצגת משקיעים בסיום | כלל 17, סקיל `investor-deck` |
| תשתית לדוחות רבעוניים ושנתיים | כלל 17, סקיל `periodic-reports`, תבניות KPI ודוחות |
| מודל עסקי נוכחי ותחזית עתידית | כלל 17, סקיל `business-model` |
| MVP ראשון ובדיקת POC דרך האינטרנט | כלל 17, סקיל `mvp-poc` |
| סדר כל השלבים | סקיל `project-kickoff`, `PROJECT-STATUS.md` |
| קופירייטר | סקיל `copywriting` (מ-marketingskills) |
| עיצוב בסגנון Apple לאתרים, לדפי נחיתה ול-Expo | סקילים `apple-design`, `mobile-native`, `animate-expo` (מ-emilkowalski/skills) |
| ארכיטקט אתרים | סקיל `site-architecture` (מ-marketingskills) |
| פסיכולוג שיווקי | סקיל `marketing-psychology` (מ-marketingskills) |
| אופטימיזציית CTR מ-Search Console | סקיל `gsc-ctr-optimizer` |
| ניתוח רילסים מכל פלטפורמה ותסריטים | סקיל `universal-reel-analyzer` (מחליף את social-reel-analyzer) |
| ניתוח כל דף, אתר, מערכת או מודעה | סקיל `web-page-analyzer` |
| שותף עיצוב פרונט: טעם, טוקנים ובדיקה ויזואלית | סקיל `frontend-design-partner` |
| ייבוא אתר או מערכת ל-Stitch דרך MCP | סקיל `site-to-stitch` |
| עקיפת מתחרים בגוגל | סקיל `competitor-content-gap` |
| איחוד כל סקילי השיווק, ה-SEO והעיצוב לתהליך אחד | סקיל `growth-engine` |

## התקנה חד-פעמית
```bash
cd spacode-ai-kit
git init && git add -A && git commit -m "chore: spacode ai kit v2.0.0"
gh repo create <owner>/spacode-ai-kit --private --source=. --push
```

## בכל פרויקט חדש: דרך סוכן ה-AI (הכי פשוט)
פותחים את הפרויקט ב-Cursor ומדביקים לסוכן:
> התקן בפרויקט הזה את ערכת Spacode מ-https://github.com/<owner>/spacode-ai-kit לפי הקובץ AI-INSTALL.md שבמאגר

הסוכן קורא את `AI-INSTALL.md`, שואל שם פרויקט, לקוח ואם יש אפליקציה, משכפל את הערכה לתיקייה זמנית, מריץ את
ההתקנה ומדווח מה הותקן.

## או בפקודה אחת בטרמינל
```bash
gh repo clone <owner>/spacode-ai-kit /tmp/kit -- --depth 1 && \
bash /tmp/kit/scripts/bootstrap.sh <owner>/spacode-ai-kit . --name "<Product>" --client "<Client>" [--hosting railway|aws] [--mobile]
```

## בכל פרויקט חדש: ידנית
```bash
gh repo create <owner>/<client>-<product> --private --clone
~/spacode-ai-kit/scripts/install-spacode-kit.sh ./<client>-<product> --name "<Product>" --client "<Client>" --owner <github-user> [--hosting railway|aws] [--mobile]
cd <client>-<product> && git add -A && git commit -m "chore: apply spacode ai kit" && git push -u origin main
~/spacode-ai-kit/scripts/setup-github.sh <owner>/<client>-<product> --hosting <railway|aws>
git switch develop && git branch -D main      # במחשב נשאר רק develop
```
אחר כך מגדירים את `STITCH_API_KEY` כמשתנה סביבה במחשב, בודקים ב-Cursor Settings → MCP ש-stitch מחובר, וכותבים
ב-Cursor: **"תריץ את הסקיל project-kickoff"**.

## מה צריך להגדיר ידנית (הסקריפטים מדפיסים את הרשימה)
- **GitHub Environments:** משתנים `WEB_URL`, `API_URL`, `RAILWAY_SERVICES`, וסודות `RAILWAY_TOKEN` (טוקן פרויקט לכל סביבה), `E2E_USER`, `E2E_PASSWORD`, ו-`EXPO_TOKEN` לאפליקציות. ב-production מוגדר אישור ידני.
- **Railway:** פרויקט עם 3 סביבות ושירות לכל רכיב. ה-autodeploy כבוי, כי `pipeline.yml` מבצע את הפריסה אחרי שהבדיקות עוברות.
- **האפליקציות:** צריכות להגיש `/version.json` (ה-pipeline כותב אותו) ו-`/health/ready`, כדי שה-pipeline יוכל לוודא שהגרסה החדשה עלתה.
- **סקריפטים ב-package.json:** `lint`, `typecheck`, `test`, `test:integration`, `test:e2e`, `build`, `db:migrate:deploy`. סקיל `full-test-suite` מקים אותם.

## סקילים חיצוניים
שישה סקילים מגיעים ממאגרים חיצוניים ברישיון MIT (הפירוט ב-`THIRD_PARTY_NOTICES.md`). התוכן שלהם לא שונה. בראש כל אחד נוסף רק קטע "Spacode adapter" קצר, שמפנה למיתוג ולמסמכי הפרויקט, מגדיר עברית ו-RTL, וממפה סקילים שלא קיימים בערכה לסקילים המקבילים שלנו.
כדי למשוך עדכונים מהמאגרים המקוריים: `./scripts/update-vendored-skills.sh`. הסקריפט מוריד, מחליף, ומחיל מחדש את ההתאמות.

## הערות
- **1000 מאמרים:** הגוגל מעניש על "scaled content abuse", כלומר תוכן המוני בלי ערך. לכן הערכה בונה pipeline שמגיע ליעד לאורך זמן, ובו לכל מאמר יש בריף, בדיקת עובדות ואישור אנושי לפני פרסום.
- **Stitch MCP:** הכתובת היא `https://stitch.googleapis.com/mcp` עם header `X-Goog-Api-Key`. שמות הכלים של ה-MCP עשויים להשתנות, ולכן הסקיל מורה ל-AI לבדוק אילו כלים זמינים לפני שהוא משתמש בהם.
- **הגנת ענפים** במאגר פרטי דורשת מנוי GitHub בתשלום.
- **AWS:** בוחרים עם `--hosting aws`. אותם עקרונות כמו ב-Railway: פריסה רק דרך GitHub, שירות לכל רכיב (ECS, RDS, ElastiCache), תשתית כקוד ב-Terraform שעוברת plan ב-PR ו-apply אחרי מיזוג, והתחברות דרך OIDC בלי מפתחות גישה.
- **כללי פרטיות, רגולציה ותחזיות** הם הנחיות הנדסיות וניהוליות, לא ייעוץ משפטי או חשבונאי.
- הכללים והסקילים כתובים באנגלית לציות עקבי של המודל, ומורים ל-AI לענות בעברית. מסמכים ללקוח כתובים בעברית.
