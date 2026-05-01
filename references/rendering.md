# Rendering — HTML to PDF and Cover PNG

The skill ships books as four files: interior HTML, interior PDF, cover HTML, cover PNG. This file is the recipe to produce the PDF and PNG from the HTML deterministically.

## Tools

The default toolchain is **Chromium / Chrome headless**. It is preinstalled on most dev machines (`/usr/bin/chromium` on Debian/Ubuntu, `/Applications/Google Chrome.app/...` on macOS). No npm install required.

If chromium is unavailable, the alternates in order of preference:

1. `google-chrome --headless` (same flags).
2. Puppeteer screenshot workflow (heavier — install Node + puppeteer). Use when the simple flags are insufficient: web fonts not loading, multi-pass rendering, etc.
3. **Avoid** `wkhtmltopdf` and `WeasyPrint` — both fail on the design features this skill produces (drop caps, pull quotes, custom @page rules, modern CSS).

Detect what you have:

```bash
which chromium google-chrome chromium-browser
```

## Cover PNG — 1600 × 2560

Standard ebook-store cover dimensions. The cover HTML must define a fixed-size element — see `assets/the-pause-cover.html` style for reference (a `.cover` div sized exactly `1600px × 2560px`).

```bash
chromium --headless=new --disable-gpu --no-sandbox \
  --hide-scrollbars \
  --window-size=1600,2560 \
  --screenshot=<book-slug>-cover.png \
  --virtual-time-budget=8000 \
  "file://$PWD/<book-slug>-cover.html"
```

Verify dimensions:

```bash
file <book-slug>-cover.png
# expected: PNG image data, 1600 x 2560, 8-bit/color RGB
```

If the output is smaller than 1600×2560, the cover HTML is using a CSS scale transform for screen preview that did not get reset for headless. Wrap the scale in `@media screen and (max-width: 1700px)` so headless (which uses the requested viewport exactly) renders the unscaled element.

## Interior PDF — at trim size

The critical gotcha: **set `@page margin: 0` in `@media print`** so chromium does not stack its default page margins on top of the `.page` div's padding, doubling the page count.

Recipe:

```bash
chromium --headless=new --disable-gpu --no-sandbox \
  --no-pdf-header-footer \
  --virtual-time-budget=12000 \
  --print-to-pdf=<book-slug>.pdf \
  "file://$PWD/<book-slug>.html"
```

Verify page count matches the design:

```bash
pdfinfo <book-slug>.pdf | grep -E "Pages|Page size"
# expected for a 20-page 6×9 book:
#   Pages:           20
#   Page size:       432 x 648 pts   (= 6×9 in @ 72dpi)
```

### The `@page margin: 0` gotcha

Chromium's `--print-to-pdf` honours `@page` rules but enforces a default margin (about 0.4 in) when none is set, which adds to whatever padding your `.page` div has. The result: every `.page` overflows by the margin amount and chromium emits two PDF pages per design page.

The interior CSS must include this block:

```css
@media print {
  @page { size: 6in 9in; margin: 0; }
  html, body { background: var(--color-paper); }
  .book {
    background: var(--color-paper);
    padding: 0;
    gap: 0;
    display: block;
    min-height: 0;
  }
  .page {
    box-shadow: none;
    margin: 0;
    width: 6in;
    height: 9in;
    min-height: 0;
    max-height: 9in;
    overflow: hidden;
    page-break-after: always;
    break-after: page;
  }
  .page:last-of-type { page-break-after: auto; break-after: auto; }
}
```

If the page count doubles, this block is the first thing to check. Replace `6in 9in` with the trim size you chose.

The shipped `assets/premium-ebook.css` already contains this block. If you write a custom stylesheet, copy it.

## Web fonts

Chromium downloads webfonts before rendering when given enough time. The `--virtual-time-budget` flag controls how long it waits.

- **8 seconds** is enough for one or two Google Fonts families.
- **12 seconds** for an interior with multiple weights and italic.
- If type renders as a fallback, increase the budget or self-host the fonts.

To self-host (recommended for production deliveries — Google Fonts CDN can stall in CI):

```html
<link rel="preload" href="fonts/EBGaramond-Regular.woff2" as="font" type="font/woff2" crossorigin>
<style>
  @font-face {
    font-family: 'EB Garamond';
    src: url('fonts/EBGaramond-Regular.woff2') format('woff2');
    font-weight: 400; font-style: normal; font-display: block;
  }
</style>
```

`font-display: block` (not `swap`) prevents a fallback flash from being captured before the real font loads.

## When to escalate to the Puppeteer screenshot workflow

The simple `--print-to-pdf` flow works for most premium books in this skill. Escalate to the Puppeteer screenshot workflow when:

- Drop caps render with the wrong size on the first page only.
- A pull quote breaks across two PDF pages despite `break-inside: avoid`.
- Running heads / folios from `@page` directives don't appear (chromium ignores `@top-left` etc. — use absolutely-positioned in-page divs instead, as `assets/chapter-template.html` does).
- The book uses true facing-page spreads with cross-page imagery.

The screenshot workflow renders each page as an image with Puppeteer's `page.screenshot()` and assembles a PDF from them. Heavier and slower, but pixel-faithful. The upstream `ebook-publishing` skill's `formatting.md` documents the canonical script.

## End-to-end script

For the standard four-deliverable set, this single shell function does it. Drop into the project's `output/` directory:

```bash
render_book() {
  local slug="$1"
  local cover_w="${2:-1600}"
  local cover_h="${3:-2560}"

  # Cover PNG
  chromium --headless=new --disable-gpu --no-sandbox \
    --hide-scrollbars --window-size="${cover_w},${cover_h}" \
    --screenshot="${slug}-cover.png" --virtual-time-budget=8000 \
    "file://${PWD}/${slug}-cover.html"

  # Interior PDF
  chromium --headless=new --disable-gpu --no-sandbox \
    --no-pdf-header-footer --virtual-time-budget=12000 \
    --print-to-pdf="${slug}.pdf" \
    "file://${PWD}/${slug}.html"

  # Verify
  pdfinfo "${slug}.pdf" | grep -E "Pages|Page size"
  file "${slug}-cover.png"
}

render_book the-pause
```

Run after every meaningful edit to either the interior or cover HTML.
