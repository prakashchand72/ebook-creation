# Design System

A book's design system is small. It should fit on a single page. If it grows beyond that, the design is doing too much.

## What a book's design system contains

1. **Color tokens** — ink, paper, accent, rule, muted. Five colors total. Maybe six.
2. **Type tokens** — body face, display face, scale (8 sizes), weights (at most 3).
3. **Spacing scale** — based on the body line-height, eight steps.
4. **Grid** — page margins (T/R/B/L), text column max-width, baseline grid value.
5. **Components** — chapter opener, pull quote, callout, figure, table — as defined in `interior-design.md`.

That's it. Output it as a `design-tokens.json` file (template in `assets/`) and reference those tokens from CSS via custom properties.

## Color

A premium book uses **one ink, one paper, one accent, two neutrals**.

```
ink       — the body text color. Almost never pure #000.
paper     — the background. Almost never pure #FFF.
accent    — used 1-3 times per spread, max. For drop caps, pull-quote marks, link color.
rule      — the color of thin rules and borders. A washed-out version of ink.
muted     — for captions, folios, secondary text. Tints toward paper.
```

### Recommended palettes

**Editorial (default — works for 80% of books):**

```json
{
  "ink":    "#1A1A1A",
  "paper":  "#FAF8F4",
  "accent": "#8B2E2E",
  "rule":   "#D9D4CB",
  "muted":  "#6B6B6B"
}
```

**Modern minimalist (tech, business, design):**

```json
{
  "ink":    "#0E0E0E",
  "paper":  "#FFFFFF",
  "accent": "#FF4A1C",
  "rule":   "#E5E5E5",
  "muted":  "#737373"
}
```

**Warm narrative (memoir, fiction, lifestyle):**

```json
{
  "ink":    "#2C1810",
  "paper":  "#F4EDE0",
  "accent": "#A0522D",
  "rule":   "#D4C7B0",
  "muted":  "#7A6A55"
}
```

**Dark (specialty — only if the book is meant to be read in dark mode by default):**

```json
{
  "ink":    "#E8E4DC",
  "paper":  "#161514",
  "accent": "#E8B566",
  "rule":   "#2C2A27",
  "muted":  "#9A958A"
}
```

### Color rules

- **Never use pure black on pure white.** It vibrates. Tone the ink down 5–10% and warm the paper 3–5%.
- **The accent is for emphasis, not decoration.** Drop cap, pull-quote marks, link color, the thin chapter-opener rule. That's it. Not for body text. Not for headings.
- **Chapter numbers can be in the accent color** if and only if they're treated as decorative (set very large, with the title in ink below). Otherwise they're in ink.
- **Test contrast** at every body-text color combination. WCAG AA requires 4.5:1 for body, 3:1 for large text (≥18pt). Use a checker.

## Spacing scale

Anchor everything to the body line-height. If body is 17px × 1.6 = **27.2px line-height**, your scale is multiples of that.

| Token | Value (× line-height) | Pixels (at 27.2px LH) | Use |
|---|---|---|---|
| `--space-2xs` | 0.25 | 7px | Tight gaps inside components |
| `--space-xs`  | 0.5  | 14px | Caption-to-figure, list-item-to-bullet |
| `--space-sm`  | 0.75 | 20px | Paragraph spacing (instructional mode) |
| `--space-md`  | 1.0  | 27px | Default vertical rhythm unit |
| `--space-lg`  | 1.5  | 41px | After H3 |
| `--space-xl`  | 2.0  | 54px | After H2, around pull quotes |
| `--space-2xl` | 3.0  | 82px | Section breaks, around full-bleed figures |
| `--space-3xl` | 5.0  | 136px | Chapter opener top margin |

**Rule**: every vertical space in the book should be one of these eight values. If you find yourself wanting `35px`, you actually want `--space-lg` (41px). Discipline here is what creates the *felt* grid.

## Page grid

For HTML→PDF or fixed-layout EPUB, set page margins explicitly:

```css
@page {
  size: 6in 9in;            /* trade paperback — premium default */
  margin: 22mm 18mm 24mm 18mm;
}
```

For reflowable EPUB, you can't control page size — but you can set the text column inside the body:

```css
body { padding: 0 1.5em; }
.chapter__body { max-width: 34rem; margin-inline: auto; }
```

### Trim sizes — pick deliberately

| Size | Use | Notes |
|---|---|---|
| **5.5 × 8.5 in** | Fiction, memoir, novella | Pocket-feeling. Standard mass-market trade. |
| **6 × 9 in** | Non-fiction default | The premium standard. Most "real books" are this size. |
| **5.5 × 8.25 in** | Self-help, business | Tighter than 6×9, feels modern. |
| **7 × 10 in** | Workbooks, technical, design | Larger pages need denser content or they look empty. |
| **8.5 × 11 in** | Lookbooks, art books | Magazine-feeling. Requires real photography or illustration to justify the size. |

Don't pick a trim size because "it makes the page count higher" or "it's cheaper to print". Pick because it fits the content.

## Baseline grid

Every line of body text should sit on an invisible line that's a multiple of the line-height. Heading sizes and spacing should snap to those lines.

In CSS:

```css
:root {
  --baseline: 1.6rem;   /* one line of body */
}
.chapter__body p { line-height: var(--baseline); margin: 0 0 var(--baseline) 0; }
.chapter__body h2 {
  font-size: var(--type-2xl);
  line-height: calc(var(--baseline) * 1.5);   /* 1.5 baselines tall */
  margin-top: calc(var(--baseline) * 2);      /* snaps */
  margin-bottom: var(--baseline);
}
```

You won't see the grid. You'll feel it. The page will read calmer than a page where the spacing is "close enough".

## Component definitions

Don't redesign components per chapter. Define each one once, in the design system, and reuse:

- `.chapter` — outer container, page-break before
- `.chapter__opener` — the title block
- `.chapter__body` — the text column, max-width 34rem
- `.lead` — first paragraph, optional larger size, no indent
- `.pullquote` — the design's signature element
- `.callout` (with modifier classes `--note`, `--warn`, `--insight`)
- `.figure` (with `figcaption`)
- `.table` (with `.num` for right-aligned numeric cells)
- `.section-break` — three-glyph centered break

Use BEM-like naming. Don't use utility classes (`mt-4 text-lg`) — books outlive utility-CSS frameworks.

## How to deliver the system to the user

When the user says "yes, design a book for me," respond with:

1. The chosen palette (5 colors, with reasoning — 1 sentence each)
2. The chosen type pair (body face / display face, with reasoning)
3. The trim size + page grid
4. A link or inline render of the chapter opener (single sample)

Get a yes. Then build the rest. **Never** generate 50 chapters in a system the user hasn't approved on a single chapter first.
