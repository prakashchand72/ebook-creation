# Accessibility

Accessibility is a craft signal, not a compliance burden. Books designed for screen readers, dyslexic readers, and low-vision readers also pass EPUBCheck on the first try, sail through Apple Books review, and rank better in Amazon's accessibility-aware filtering. Premium and accessible are the same project.

## The non-negotiables

These are required for any book to be considered "done" in this skill:

1. **Semantic HTML.** Use real elements: `<h1>`, `<h2>`, `<p>`, `<figure>`, `<figcaption>`, `<aside>`, `<blockquote>`, `<nav>`, `<section>`. Never `<div class="heading">` or `<span class="quote">`.
2. **One `<h1>` per chapter.** Subsections use `<h2>`, `<h3>`. Don't skip levels (no `<h2>` directly to `<h4>`).
3. **Logical reading order in source.** A screen reader reads in DOM order. If you visually move a pull quote with CSS, the pull quote still reads in its source position — make sure that source position makes narrative sense (or mark `aria-hidden="true"` if it's a duplicate of body text).
4. **All images have meaningful `alt` text.** See section below for the difference between *meaningful* and *bad* alt text.
5. **Color contrast ≥ 4.5:1** for body text against background. ≥ 3:1 for large text (≥18pt or 14pt bold). Test the chosen palette before committing.
6. **No information conveyed by color alone.** "The red bullets are required, the gray ones are optional" fails. Use a label, a symbol, or a position.
7. **Links describe their destination.** `<a href="/ch5">read more about pricing</a>`, not `<a href="/ch5">click here</a>`.
8. **Tables use `<th>` with `scope="col"` or `scope="row"`** so screen readers announce headers correctly when reading cells.

## Alt text — the hard part

Bad alt text is worse than missing alt text. The rules:

| Image type | Alt text rule |
|---|---|
| **Decorative** (rule lines, ornaments, end-of-chapter glyphs) | `alt=""` AND `aria-hidden="true"`. Don't describe ornaments. |
| **Informative** (a chart, diagram, photo with content) | A sentence that conveys what a sighted reader would *understand* from the image — not what they would *see*. |
| **Functional** (a button or link image) | Describe the action: `alt="next chapter"`, not `alt="arrow icon"`. |
| **Complex** (a multi-part diagram, a data visualization) | Short alt + a longer description nearby in the body or in a `<figure><figcaption>` block, or via `aria-describedby`. |

**Examples:**

Bad: `alt="image"` / `alt="chart"` / `alt="cover.jpg"` / `alt="a man standing in a field"`
Good: `alt="A line chart showing book sales doubling between 2020 and 2024, with a sharp dip in mid-2022."`

Bad: `alt="quote marks"`
Good: `aria-hidden="true"` (decorative — the same words exist in the body)

Bad: `alt="diagram of the funnel"`
Good: `alt="Marketing funnel with four stages: awareness (1000 visitors), interest (200), consideration (50), purchase (10). Conversion rate falls from 20% to 5% to 20% at each stage."`

The rule of thumb: **if the image were missing, would the reader still get the information?** That's what your alt text needs to deliver.

## EPUB-specific accessibility (EPUB 3)

EPUB 3 has accessibility metadata. Include it in the OPF package file:

```xml
<metadata>
  <meta property="schema:accessibilityFeature">structuralNavigation</meta>
  <meta property="schema:accessibilityFeature">readingOrder</meta>
  <meta property="schema:accessibilityFeature">alternativeText</meta>
  <meta property="schema:accessibilityHazard">none</meta>
  <meta property="schema:accessibilitySummary">
    This publication conforms to WCAG 2.1 Level AA. All images include
    descriptive alternative text. Reading order is logical and follows
    the document outline.
  </meta>
  <meta property="schema:accessMode">textual</meta>
  <meta property="schema:accessMode">visual</meta>
  <meta property="schema:accessModeSufficient">textual</meta>
</metadata>
```

This metadata makes the book discoverable to readers using accessibility filters on Apple Books, Kobo, and accessibility-focused libraries. It's a 30-second add for a real benefit.

### Use semantic ePub roles

EPUB 3 supports DPUB-ARIA roles for book structures:

```html
<section epub:type="chapter" role="doc-chapter" aria-labelledby="ch3-title">
  <h1 id="ch3-title">The Quiet Year</h1>
  ...
</section>

<aside epub:type="footnote" role="doc-footnote" id="fn1">
  <p>Source: …</p>
</aside>

<a epub:type="noteref" role="doc-noteref" href="#fn1">1</a>

<section epub:type="bibliography" role="doc-bibliography">
  ...
</section>
```

Use `epub:type` values from the [Structural Semantics Vocabulary](https://idpf.org/epub/vocab/structure/) — `cover`, `frontmatter`, `bodymatter`, `backmatter`, `chapter`, `part`, `dedication`, `epigraph`, `toc`, `colophon`, `acknowledgments`, `bibliography`, `glossary`, `index`, `appendix`, `footnote`, `noteref`, `pagebreak`.

## Reading order — the trap

Screen readers read in source order. That means:

- Pull quotes in `<aside>` will be read **at the position they appear in the HTML**, even if visually they're hung in the margin. That's why pull quotes that duplicate body text should be `aria-hidden="true"`.
- Image captions belong **inside the `<figure>`**, not in a separate floating div positioned next to the image.
- Sidebars (real sidebars, with content not in body) should be in source order at a sensible position — usually right after the paragraph that introduces the topic.
- Page break markers (`<span epub:type="pagebreak" id="page42" role="doc-pagebreak" aria-label="42">`) should appear at the position of the print page break.

## Contrast — the math

Use a contrast checker (e.g., webaim.org/resources/contrastchecker, the macOS Digital Color Meter, or any browser devtool). For the recommended palettes in `design-system.md`:

| Palette | Body contrast | Pass? |
|---|---|---|
| Editorial: `#1A1A1A` on `#FAF8F4` | 16.1 : 1 | AAA |
| Modern minimalist: `#0E0E0E` on `#FFFFFF` | 19.4 : 1 | AAA |
| Warm narrative: `#2C1810` on `#F4EDE0` | 12.4 : 1 | AAA |
| Dark: `#E8E4DC` on `#161514` | 13.7 : 1 | AAA |

Muted text (captions, folios) needs **3:1 minimum** — and many "soft gray" choices fail this. Test specifically.

## Dyslexia-friendly defaults you can leave in

These don't hurt anyone and meaningfully help dyslexic readers:

- Body line-height ≥ 1.55 (already in the typography reference).
- Body line length 60–75 characters (already in the typography reference).
- Generous paragraph spacing (already in the spacing scale).
- Avoid full justification with poor hyphenation (rivers of white space hurt dyslexic readers most).
- Don't use italic for long blocks of text. Italics specifically reduce dyslexic reading speed. Use them for emphasis within a sentence, not for entire paragraphs or block quotes.

You don't need to use OpenDyslexic or any "dyslexia font". The defaults above do most of the work.

## Audiobook accessibility

If the book is also an audiobook (see `ebook-publishing` skill's `audiobooks.md`):

- Chapter titles should be spoken at the start of each chapter file, not silently displayed.
- Footnote markers in the print should not be read aloud as numbers — they should be skipped or read as "see note" with the note read at chapter end.
- Front matter and back matter should be in the audiobook unless the publisher confirms otherwise. Listeners deserve the full book.

## What to verify

Before declaring the book done:

- [ ] Every `<img>` has `alt`. Decorative images have `alt=""` and `aria-hidden="true"`.
- [ ] Every chapter has exactly one `<h1>`.
- [ ] Heading levels don't skip.
- [ ] Tables use `<th scope="…">`.
- [ ] Links describe destinations, not "click here".
- [ ] Body text contrast ≥ 4.5:1 on the chosen palette.
- [ ] EPUB 3 metadata declares accessibility features.
- [ ] `epub:type` and `role` attributes are on chapters, footnotes, TOC, etc.
- [ ] No information is conveyed by color alone.
- [ ] Read the book with VoiceOver (macOS/iOS) or NVDA (Windows). Listen to one chapter end-to-end.
