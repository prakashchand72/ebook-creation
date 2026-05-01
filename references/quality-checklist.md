# Quality Checklist — Pre-Publish QA

Run this before declaring the book finished. Every item is a hard gate. Fail one, fix it, run the list again.

## 1. Design system integrity

- [ ] **One body face, one display face.** No third or fourth typeface has crept in.
- [ ] **Color tokens used consistently.** No off-palette colors (especially in figures and charts — the most common drift).
- [ ] **Spacing scale respected.** No `margin-top: 35px` when the scale says 27 or 41.
- [ ] **Drop caps render correctly** on the first paragraph of every chapter (not just the first chapter).
- [ ] **Section breaks within chapters are visually distinct from chapter starts.** A reader skimming should not confuse them.

## 2. Typography

- [ ] **Body line length 60–75 chars.** Test on phone width (375px), tablet, and desktop.
- [ ] **Body line-height 1.55–1.65.**
- [ ] **No widows or orphans** at chapter and section breaks. (A single line at the bottom or top of a page or screen — fix with `widows: 2; orphans: 2;` and manual `<wbr>` if needed.)
- [ ] **No "rivers"** of white space in justified text. Either turn on hyphenation or unjustify.
- [ ] **Numbers in body are oldstyle figures** (`font-feature-settings: "onum" 1`).
- [ ] **Numbers in tables are tabular figures** (`"tnum" 1`).
- [ ] **Em-dashes, en-dashes, and hyphens are used correctly** — em (`—`) for parenthetical breaks, en (`–`) for ranges (1939–1945), hyphen (`-`) for compound words.
- [ ] **Smart quotes** ("…" and '…'), not straight quotes ("…" and '…').
- [ ] **Apostrophes** are typographic (`'`), not vertical (`'`).
- [ ] **Ellipses** are single character `…`, not three periods `...`.

## 3. Front and back matter

- [ ] **Title page** present and composed (not auto-generated).
- [ ] **Copyright page** with current year, ISBN if applicable, attribution for any third-party assets, "All rights reserved", edition number.
- [ ] **Table of contents** reflects actual chapter titles. Links jump correctly in EPUB.
- [ ] **Dedication, epigraph** if present, each on its own page.
- [ ] **Acknowledgments** page is real, not generic.
- [ ] **About the author** doesn't read like a LinkedIn bio.
- [ ] **Colophon** (optional but premium) names typefaces and conversion process.

## 4. Chapters

- [ ] **Chapter openers identical in structure.** Eyebrow → title → optional epigraph → rule → drop cap. No drift from chapter to chapter.
- [ ] **Chapter numbers consistent** in style (numerals vs roman vs spelled-out).
- [ ] **Every chapter ends with a closing mark** (the centered ornament).
- [ ] **No chapter ends mid-sentence or mid-thought** because a paragraph got cut.
- [ ] **Running heads and folios** correct on every page (for PDF). Running head correct on chapter openers (usually suppressed).

## 5. Figures, tables, callouts

- [ ] **Every figure has a caption.** Every caption has a number (Fig. 1.1, etc.) consistent across the book.
- [ ] **Every figure has alt text.** Real alt text, not `alt="image"`.
- [ ] **Every table has `<th scope="col">`** or `scope="row"` headers.
- [ ] **Every table uses tabular figures** for numeric columns.
- [ ] **Callouts use the same style** book-wide (don't have three different callout designs).
- [ ] **Pull quotes don't visually conflict** with figures on the same page/spread.

## 6. Accessibility

- [ ] **Body text contrast ≥ 4.5:1.** Tested with a tool, not eyeballed.
- [ ] **All headings semantic** (`<h1>`, `<h2>`, …). No `<div class="heading">`.
- [ ] **Heading levels don't skip** (no h2 → h4).
- [ ] **One `<h1>` per chapter.**
- [ ] **EPUB metadata declares accessibility features** (see accessibility.md).
- [ ] **DPUB-ARIA roles** on chapter, footnote, noteref, TOC, etc.
- [ ] **No information conveyed by color alone.**
- [ ] **Decorative elements have `aria-hidden="true"`** and `alt=""`.
- [ ] **Read with VoiceOver / NVDA** — at least one full chapter, end to end.

## 7. Cross-device rendering

- [ ] **Read on a phone (375px width)** — line length, chapter openers, pull quotes still work.
- [ ] **Read on a tablet (768px)** — text column is centered, not stretched edge-to-edge.
- [ ] **Read in dark mode** (Apple Books invert / Kindle dark theme) — contrast still passes.
- [ ] **Read at 150% zoom** — layout doesn't break.
- [ ] **Read on a real Kindle** if shipping to Amazon. The Kindle preview tool is not the same as a real device.

## 8. Files

- [ ] **EPUB passes EPUBCheck.** Zero errors. Warnings reviewed and either fixed or justified.
- [ ] **PDF embeds all fonts.** No "font not embedded" warnings.
- [ ] **PDF passes Acrobat preflight** for "PDF/X-1a" if going to print.
- [ ] **Image assets are right-sized.** No 4000px PNGs in a body figure that displays at 600px. WebP or JPG, not PNG, for photographic images.
- [ ] **No proof watermarks** in any image (very common bug).
- [ ] **Filename of the deliverable** is the title and version (`title-of-book-v1.epub`), not `final_FINAL_v3.epub`.

## 9. Cover

- [ ] **Cover legible at 200×300 thumbnail.** Title readable, genre clear, mood clear.
- [ ] **Title and author contrast against background ≥ 7:1.** Higher than body, because thumbnail.
- [ ] **No drop shadows, bevels, or default Photoshop styles.**
- [ ] **Spine designed** (for print) with title, author, publisher mark.
- [ ] **Back cover designed** (for print) — hook, blurbs, bio, ISBN.
- [ ] **Cover file separate from EPUB cover image.** EPUB cover image is 1600×2560 minimum, sRGB.

## 10. Content

- [ ] **No "lorem ipsum" or placeholder text** anywhere. (Search the whole project for "lorem".)
- [ ] **No TODO comments** in the manuscript. (Search "TODO".)
- [ ] **All links resolve.** External and internal.
- [ ] **All citations have sources.** Sources reachable.
- [ ] **Spelling pass with at least one tool.** Spell-checkers miss "manger" for "manager" — also do a manual read.
- [ ] **Read the first sentence of every chapter aloud.** Read the last sentence of every chapter aloud. Both should land.

## 11. Metadata

- [ ] **Title, subtitle, author, ISBN** match across the book file, the cover, and the platform listing.
- [ ] **Publication date** correct.
- [ ] **Genre / BISAC categories** chosen deliberately (see `ebook-publishing` skill).
- [ ] **Description / blurb** written, not auto-generated from chapter 1.
- [ ] **Keywords** chosen (Amazon allows 7).

## 12. Deliverables — the four-file contract

The skill ships exactly four files per book. QA fails if any are missing.

- [ ] `output/<book-slug>.html` exists.
- [ ] `output/<book-slug>.pdf` exists. `pdfinfo` shows the expected page count and trim size.
- [ ] `output/<book-slug>-cover.html` exists.
- [ ] `output/<book-slug>-cover.png` exists at 1600×2560 (or the trim-matched size). `file <path>` confirms dimensions.
- [ ] **No `<book-slug>-cover.pdf`** — if one was generated by an earlier draft, delete it.
- [ ] No leftover QA images (`check-*.png`, `preview-*.png`) committed alongside the deliverables.

If any file is missing or wrong, see `references/rendering.md` and re-run the render commands.

## 13. The final read

The whole-book read, on the device the typical reader will use, in one sitting if possible. You're not editing — you're feeling the rhythm. Mark anything that pulls you out. Fix the marks. Then ship.

If a single round of this checklist takes less than two hours, the book wasn't checked carefully enough. Plan a half-day for QA on the final candidate.
