# Interior Design

The inside of the book. This is where readers spend 99% of their time and where amateur books reveal themselves.

## Front matter, in order

A premium book includes most of these. Each gets its own page (page break). Skipping these is the second-biggest tell of a self-published book (after typography).

| Page | Required? | Notes |
|---|---|---|
| Half-title | Optional, premium | Title only, centered, set small. A breath before the book. |
| Frontispiece | Optional | Image, illustration, or epigraph facing the title page. |
| Title page | Yes | Full title, subtitle, author, publisher mark. The composed equivalent of the cover. |
| Copyright | Yes | © year, author name, ISBN, edition, "All rights reserved", attribution for any third-party assets. Set in `--type-xs`. |
| Dedication | Optional | One line. Centered. Italic. A lot of vertical space around it. |
| Epigraph | Optional | A quote that sets tone. Attribution beneath, em-dash, set in small caps. |
| Table of contents | Yes for non-fiction, optional for fiction | Premium TOCs use a clean two-column grid: chapter title left, page number right, dotted leader between. For ebooks, omit page numbers and use a flat list with hover/tap states. |
| Foreword / Preface / Introduction | Optional | Each on its own page, treated like chapters. |

## Back matter, in order

| Page | Required? | Notes |
|---|---|---|
| Acknowledgments | Yes | Set generously — readers who reach the back are fans. |
| About the author | Yes for non-fiction | One paragraph, photo optional. Avoid bullet-list "achievements" — read like a person, not a LinkedIn profile. |
| Also by this author | If applicable | A spread or list with cover thumbnails. |
| Author's note / Methodology / Sources | If applicable | Footnotes belong at the end if numerous; chapter-end if sparse. |
| Colophon | Optional, very premium | A short paragraph naming the typefaces, paper, and (for ebooks) the conversion process. A signal of craft. |

## Chapter opener

The chapter opener is the single most-designed page in the book. Treat it like a magazine spread.

**Anatomy of a premium opener:**

1. **Generous top margin** — at least 25% of the page. The chapter title should not start at the top.
2. **Eyebrow** — small caps, one to three words. "Chapter Three" or "Part I · Origins" or section name. Set in `--type-sm` with letter-spacing 0.12em.
3. **Chapter title** — display face, large, set on 1–3 lines. Hung left or centered, never both inconsistent across chapters.
4. **Optional epigraph or pull-line** — one quote, short, italic, attributed.
5. **A horizontal mark or rule** — a single thin line, an ornament glyph (✦, §, or a custom mark), or simply more whitespace. This is the breath before the body begins.
6. **Drop cap on the first paragraph** — see typography reference. The first 3–5 words after the drop cap are in small caps.
7. **No first-line indent** on the first paragraph after the drop cap.

```html
<section class="chapter" id="ch-03">
  <header class="chapter__opener">
    <p class="chapter__eyebrow">Chapter Three</p>
    <h1 class="chapter__title">The Quiet Year</h1>
    <p class="chapter__epigraph">
      "Patience is also a form of action."
      <cite>— Auguste Rodin</cite>
    </p>
    <hr class="chapter__rule" aria-hidden="true">
  </header>

  <div class="chapter__body">
    <p class="lead">
      It was raining the morning the letter arrived…
    </p>
    <p>The next paragraph here, with first-line indent…</p>
  </div>
</section>
```

## Body composition

- **Paragraphs**: see typography reference for indents/spacing. Pick one mode and stick with it.
- **Section breaks within a chapter**: three centered glyphs (`✦ ✦ ✦` or `* * *`) with substantial vertical space above and below — at least 2× normal line-height. Never use a horizontal rule for a section break inside a chapter.
- **Block quotes**: indented from both sides, set one size smaller than body, italic *or* roman (not both — pick a system), with a thin colored vertical bar on the left. Attribute on a new line, em-dash, small caps name.
- **Lists**: bullets in the accent color. Hanging indent — bullets sit in the margin, text aligns to a single line. Tighter line-height than body (1.4) but more space *between* items.

## Pull quotes

A pull quote is a callout — a phrase from the body, blown up, repeated visually. Used **sparingly** — at most one per chapter, never on the same spread as another design feature.

**Composition:**

- Display face, weight 400 (not bold).
- 1.5–2× body size. The eye should be drawn before the reader knows why.
- Set against generous margin — break the text column, hang into the outer margin if possible.
- Optional: opening and closing quotation marks set as a separate decorative element, larger and lighter than the quote text. (`color: var(--color-accent); opacity: 0.5;`)
- Never duplicate exactly the same words from the body — slightly tighten the phrasing for the pull.

```html
<aside class="pullquote" aria-hidden="true">
  <p>The product isn't the feature list. The product is what the customer feels at 11pm on a Sunday.</p>
</aside>
```

`aria-hidden="true"` because the same words exist in the body — screen readers shouldn't read them twice.

## Figures and images

**Every image is a figure**, with a caption, and (almost always) a number.

```html
<figure class="figure">
  <img src="figures/03-pricing-curve.webp" alt="A descending curve showing price elasticity for premium ebooks, dropping from $29 to $9 with corresponding rise in unit sales.">
  <figcaption>
    <span class="figure__num">Fig. 3.1</span>
    Price elasticity for premium positioning. Source: 2025 GeoLab data.
  </figcaption>
</figure>
```

- Caption set in `--type-xs`, sans-serif (display face), tighter line-height (1.4).
- Figure number in small caps before the caption text.
- Source attribution at the end, italic.
- Image must have meaningful alt text — see accessibility reference.
- Use `.webp` for ebooks (smaller files, supported in EPUB 3 and modern PDF readers).
- Image inside the body must respect the type column — `max-width: 100%`, `height: auto`, but for "full bleed" images break out with negative margins or a wider parent container.

## Tables

Premium tables look like financial tables in a glossy magazine, not like Excel.

```css
.table {
  width: 100%;
  border-collapse: collapse;
  font-feature-settings: "tnum" 1; /* tabular figures */
  font-size: var(--type-sm);
}
.table thead th {
  text-align: left;
  font-variant: small-caps;
  letter-spacing: 0.06em;
  font-weight: 500;
  border-bottom: 1px solid var(--color-ink);
  padding: 0.5em 0.75em;
}
.table tbody td {
  border-bottom: 0.5px solid var(--color-rule);
  padding: 0.5em 0.75em;
}
.table .num { text-align: right; }
```

- No vertical lines. Almost never. The eye doesn't need them.
- Numbers right-aligned. Always. With tabular figures.
- Headers in small caps, not bold. Not uppercase by `text-transform`.
- Zebra striping is unnecessary if row spacing is generous.

## Sidebars and callouts

A callout is content that sits *adjacent* to the main flow — a definition, a warning, a tip, a sidebar story.

Three patterns, pick one per book and stick to it:

1. **Box** — bordered, padded, with a label. The most common. Use a thin (0.5px) border in a neutral color, not a fill.
2. **Margin note** — set in the outer margin in a smaller size. Beautiful but only works in a print/PDF layout with wide margins, not in reflowable EPUB.
3. **Inline rule** — content set off with horizontal rules above and below, no border, no fill. The most editorial-feeling.

```html
<aside class="callout callout--note">
  <p class="callout__label">Note</p>
  <p>Tabular figures align vertically. Use them in tables, never in body copy.</p>
</aside>
```

## Footnotes

- **In non-fiction**, prefer chapter-end notes over page-end footnotes for ebooks (footnotes don't reflow well in EPUB).
- For HTML→PDF, true footnotes are doable but expensive in CSS — use `position: running()` with `@page` rules, or accept that they'll be at the end of each chapter.
- Footnote markers in the body: superscript numbers, in the accent color.
- Footnote text: `--type-xs`, slightly tighter leading, hanging indent so the number sits in the margin.

## Chapter end

Don't just stop. Premium books mark the end of a chapter:

- A centered ornament — three dots, a custom glyph, the publisher's mark.
- Substantial vertical space after the last paragraph.
- The next chapter starts on a fresh recto (right) page in print, on a new screen in ebook.

```html
  <hr class="chapter__end" aria-hidden="true">
</section>
```

```css
.chapter__end {
  border: 0;
  margin: 3em auto 0;
  width: 1.5em;
  height: 1.5em;
  background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'><circle cx='4' cy='12' r='1.5'/><circle cx='12' cy='12' r='1.5'/><circle cx='20' cy='12' r='1.5'/></svg>");
  background-repeat: no-repeat;
  background-position: center;
}
```

## Running heads and folios

In print/PDF, every page (except chapter openers and front matter) has:

- **Folio** (page number) — usually outer corner, in `--type-sm`.
- **Running head** — book title on verso (left) pages, chapter title on recto (right) pages. Set in small caps, `--type-sm`.

Use CSS Paged Media for HTML→PDF:

```css
@page {
  margin: 22mm 18mm 24mm 18mm;
  @top-left { content: string(book-title); font-variant: small-caps; }
  @top-right { content: string(chapter-title); font-variant: small-caps; }
  @bottom-center { content: counter(page); }
}
@page :first { @top-left { content: ""; } @top-right { content: ""; } @bottom-center { content: ""; } }
.chapter h1 { string-set: chapter-title content(); }
```

For ebooks (reflowable EPUB), the reader's app handles this — don't fight it.

## What to verify before signing off on interior design

- Every chapter opener uses the same eyebrow/title/rule structure. No drift.
- Section breaks within chapters are visually distinct from chapter breaks.
- All figures have captions and alt text. No bare `<img>`.
- All tables use tabular figures, no vertical rules, small-caps headers.
- Footnote markers are reachable as links and have `aria-describedby` or proper `role="doc-noteref"`.
- The TOC links jump to the correct chapter on tap (test in a real EPUB reader, not just the editor).
