---
name: ebook-creation
description: >
  Premium ebook creation, design, and craft — the skill for making a book
  feel high-end, not just shippable. Use whenever the user is writing,
  designing, typesetting, laying out, or polishing the *interior* and
  *experience* of an ebook: typography systems, type pairing, vertical
  rhythm, chapter openers, drop caps, pull quotes, callouts, sidebars,
  figure captions, table design, footnote styling, running heads, folios,
  front and back matter, table of contents, dedication, epigraph,
  acknowledgments, colophon, design tokens, color palette, spacing scale,
  grid, hierarchy, white space, premium cover composition, art direction,
  voice, narrative pacing, hook structure, chapter cliffhangers,
  storytelling craft, microcopy, accessibility (alt text, reading order,
  semantic EPUB), and pre-publish QA. Trigger for phrases like "premium
  ebook", "professional ebook", "high-end book design", "make this look
  expensive", "luxury ebook", "designed ebook", "Apple Books quality",
  "coffee-table feel", "magazine-quality interior", "art book", "lookbook",
  "design system for a book", or anything about polishing an ebook's craft
  rather than shipping it to a store. Includes ready-to-use CSS, HTML
  chapter templates, and design tokens. Pair with the ebook-publishing
  skill for distribution after the book is finished.
---

# Premium Ebook Creation

This skill makes ebooks feel **expensive**. It is opinionated. It is about *craft* — the things that separate a $4.99 PDF from a book a reader keeps on their device for years.

If the user is asking about platforms, royalties, or KDP/Gumroad upload, route to the `ebook-publishing` skill instead. This skill is for *making the book worth publishing*.

## The premium principles

Read these before producing anything. They override defaults in the assets.

1. **One typeface decision, executed perfectly, beats five "creative" choices.** Pair one serif for body, one sans for UI/headers — at most. No display fonts in body copy. No Google Fonts grab-bags.
2. **Whitespace is the product.** Cheap books are dense. Premium books breathe. Generous margins, line-height ≥ 1.55 for body, paragraph spacing rather than indents in non-fiction, indents (no spacing) in fiction — never both.
3. **Hierarchy through size *and* spacing, not through bold or color.** A larger font with more space above it reads as more important than the same text in red.
4. **Color is for emphasis, not decoration.** A premium book typically uses 1 ink color + 1 accent + 2 neutrals. Anything more reads as a brochure.
5. **The reader should never see the grid, but should feel it.** Consistent vertical rhythm — every element snaps to a baseline multiple. Mismatched spacing is the #1 tell of an amateur layout.
6. **Front matter is the trailer.** Half-title, frontispiece, title page, copyright, dedication, epigraph, table of contents — each on its own page, each composed deliberately. Skipping these is the second-biggest tell.
7. **The cover is one decision; the spine is another; the back is a third.** Design all three, even for an ebook (the thumbnail *is* the spine).
8. **Accessibility is not optional.** Semantic HTML, alt text on every figure, logical reading order, contrast ratio ≥ 4.5:1 for body text. This also passes EPUBCheck and Apple Books review on the first try.
9. **No emoji, no clip art, no stock photography that looks like stock photography.** If you cannot afford or commission an illustration, use type and white space.
10. **Read it on a phone before you ship it.** 60% of readers will. If chapter openers break, line-lengths overflow, or pull quotes look wrong at 375px wide, fix that first.

## When loaded, do this in order

1. **Ask once, briefly, what the book is.** Genre (fiction / non-fiction / how-to / art book / lookbook / poetry), trim size or "ebook only", and one adjective the cover should evoke. Don't make this an interview — three answers is enough to start.
2. **Propose a design system before writing a chapter.** Type pair, color tokens, spacing scale. Show the user as a tiny markdown table or a styled mock. Get a yes/no.
3. **Build one chapter end-to-end** — opener, body, pull quote, figure, end-of-chapter mark — and show it before scaling to the whole book. Iteration on a sample is 10× cheaper than iteration on a finished manuscript.
4. **Only then mass-produce.** Apply the system to the rest of the book, then run the QA checklist before handing off.

## Reference files — load on demand

| Topic | File | Load when... |
|---|---|---|
| Type system, pairing, hierarchy, vertical rhythm | `references/typography.md` | Picking fonts, setting body copy, sizing headings |
| Chapter openers, drop caps, pull quotes, callouts, end matter | `references/interior-design.md` | Designing the inside of the book |
| Color, spacing, grid, design tokens | `references/design-system.md` | Establishing the visual system; producing tokens |
| Voice, structure, pacing, hooks, microcopy | `references/content-craft.md` | The writing itself feels flat or generic |
| Premium cover direction (composition, restraint, type-only covers) | `references/covers-premium.md` | Designing the cover beyond bare specs |
| Alt text, semantic structure, EPUB a11y, contrast | `references/accessibility.md` | Any figure, table, or non-text element exists |
| Pre-publish QA gate | `references/quality-checklist.md` | Before declaring the book finished |
| Chromium headless rendering recipe + print-CSS gotchas | `references/rendering.md` | Producing the PDF and cover PNG deliverables |

## Production assets

These are ready to drop into a project. Keep tokens in sync — if the user changes the type scale in `design-tokens.json`, regenerate `premium-ebook.css`.

| Asset | Path | Purpose |
|---|---|---|
| Stylesheet | `assets/premium-ebook.css` | Production CSS for HTML→PDF (Puppeteer) and EPUB |
| Chapter template | `assets/chapter-template.html` | Reference HTML for a single chapter — opener, body, pull quote, figure, end mark |
| Design tokens | `assets/design-tokens.json` | Source of truth for color, type, spacing, used by the CSS |

## Deliverables — always ship this set

Every finished ebook produced by this skill ships **exactly four files**, in an `output/` directory inside the project. Never deliver the HTML alone. Never include a cover PDF.

| File | Purpose |
|---|---|
| `<book-slug>.html` | Interior, single-file with embedded CSS — for screen reading and editing |
| `<book-slug>.pdf` | Interior rendered to PDF at the chosen trim — for print and store upload |
| `<book-slug>-cover.html` | Cover source, standalone HTML |
| `<book-slug>-cover.png` | Cover at 1600×2560 (or trim-matched), ready for KDP / Apple Books / Gumroad upload |

**Why no cover PDF:** every store accepts the PNG; the PDF is redundant and a maintenance liability when the cover gets re-rendered.

**How to render:** see `references/rendering.md` for the chromium headless commands and the `@page margin: 0` gotcha that, if missed, doubles the interior PDF page count.

## What "done" means in this skill

- The book has a documented design system (tokens file or inline in `<style>`).
- One sample chapter has been reviewed by the user before the rest is built.
- The QA checklist in `references/quality-checklist.md` passes.
- The book has been read on a phone-width viewport without visual regressions.
- Alt text and semantic structure are in place — no `<div class="heading">`, no missing alts.
- All four deliverables (interior HTML + interior PDF + cover HTML + cover PNG) exist in `output/` and the PDF page count matches the design's intended count.

After that, hand off to the `ebook-publishing` skill for KDP/Gumroad/etc.

## What this skill will not do

- Choose for the user without asking. The three intake questions (genre / trim / mood) are non-negotiable for premium work.
- Ship a book without a sample-chapter review.
- Use Puppeteer's native `page.pdf()` for designed ebooks — see the upstream `ebook-publishing` skill's formatting reference for why. Use the screenshot workflow.
- Suggest more than two typefaces. If the user wants three, push back once and explain why; if they still want it, comply.
- Generate generic stock-feeling content. If the brief is too thin, ask for a 2-sentence positioning statement before writing.
