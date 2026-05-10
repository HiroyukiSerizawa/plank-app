# Plank Now — Play Console Store Listings

This folder contains ready-to-paste translations of the Play Console store
listing for **16 locales**, generated 2026-05-10.

## How to use

1. Open Play Console → Plank Now → **Grow › Store presence › Main store
   listing › Manage translations**.
2. Click **Add your own translations** and select the target locale from
   Play Console's locale picker (the file naming below tells you which
   locale code to pick).
3. Open the corresponding `<locale>.md` file in this folder and copy each
   of the three fields into Play Console:
   - **App name** (limit: 30 chars)
   - **Short description** (limit: 80 chars)
   - **Full description** (limit: 4000 chars)
4. Each file shows the byte/character count for verification before
   pasting.
5. Visual assets (icon, feature graphic, screenshots) auto-inherit from
   the default language listing — no upload needed per locale.
6. Save and submit for review (review queue is currently ~12 minutes per
   locale; Play Console batches them so submitting all 15 at once is
   roughly 1 review cycle, not 15).

## Locales included

### Tier S — already shipped (re-uploaded as fresh copy for consistency)
- [`source_en.md`](source_en.md) — English (United States) **and** the canonical
  source from which all other translations are derived. Use the three
  fenced blocks (App name, Short description, Full description) for the
  en-US Play Console listing; the **Tone notes** section is for
  translators only.
- [`ja.md`](ja.md) — Japanese (default language)
- [`ko_KR.md`](ko_KR.md) — Korean (South Korea)
- [`zh_TW.md`](zh_TW.md) — Traditional Chinese (Taiwan)

### Tier A — global expansion (matches app body i18n)
- [`es.md`](es.md) — Spanish (use for both **Spanish (es-ES)** and
  **Spanish (Latin America) (es-419)** in Play Console)
- [`pt_PT.md`](pt_PT.md) — Portuguese (Portugal)
- [`pt_BR.md`](pt_BR.md) — Portuguese (Brazil)
- [`de.md`](de.md) — German (Germany)
- [`fr.md`](fr.md) — French (France) — also viable for fr-CA
- [`id.md`](id.md) — Indonesian
- [`hi.md`](hi.md) — Hindi (India)
- [`vi.md`](vi.md) — Vietnamese

### Tier B — Store-only reach (no app body translation, English fallback)
- [`ru.md`](ru.md) — Russian
- [`tr.md`](tr.md) — Turkish
- [`it.md`](it.md) — Italian
- [`pl.md`](pl.md) — Polish

## Source of truth

[`source_en.md`](source_en.md) is the canonical English copy. All other
files are derivative translations that preserve the same structure
(headline → why → features → aesthetic → benefits → audience → free →
CTA). If you edit one field in one locale, mirror it across all 15 to
keep the listings coherent.

## Strategy reminder

Adding store listings does NOT add an app-body translation. Tier B
locales (ru/tr/it/pl) will see the localized store page but the app
itself in English. This is intentional — cast a wide discovery net,
measure install rates per locale in Play Console **Statistics → Store
performance**, then promote Tier B winners to Tier A in a future ARB
expansion.

## Character count quick reference

| Limit | Field |
|---|---|
| 30 chars | App name |
| 80 chars | Short description |
| 4000 chars | Full description |

CJK characters count as 1 char each. Full-width punctuation also
counts as 1.
