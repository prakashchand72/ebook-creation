# ebook-creation

A Claude Code Skill for **premium ebook creation, design, and craft** — the part that happens before publishing. Typography, interior design, design systems, content craft, premium covers, accessibility, and pre-publish QA, with production-ready CSS, HTML, and design tokens included.

Pair it with [`ebook-publishing`](https://github.com/arturseo-geo/ebook-publishing-skill) (the upstream Artur Ferreira / GeoLab skill) for distribution to KDP, Apple Books, Gumroad, etc. This skill stops at "the book is finished"; that one starts at "now ship it".

---

## What you get

- An opinionated **routing description** so Claude Code auto-invokes the skill on phrases like *premium ebook*, *high-end book design*, *make this look expensive*, *Apple Books quality*, *magazine-quality interior*.
- **Eight reference files** loaded on demand, scoped to one topic each (typography, interior design, design system, content craft, premium covers, accessibility, quality checklist, rendering).
- **Three drop-in production assets**: a CSS stylesheet, an HTML chapter template with EPUB 3 / DPUB-ARIA roles, and a `design-tokens.json` source-of-truth file.
- A **fixed deliverable contract** — every finished book ships HTML + PDF + cover HTML + cover PNG. No cover PDF.

```
ebook-creation/
├── SKILL.md                            # always loaded — routing + principles
├── references/
│   ├── typography.md                   # type pairs, modular scale, drop caps
│   ├── interior-design.md              # chapters, pull quotes, figures, tables
│   ├── design-system.md                # color, spacing, grid, trim sizes
│   ├── content-craft.md                # voice, structure, sentence-level fixes
│   ├── covers-premium.md               # cover archetypes, genre rules
│   ├── accessibility.md                # alt text, EPUB a11y, contrast
│   ├── quality-checklist.md            # 12-section pre-publish QA
│   └── rendering.md                    # chromium headless recipe + PDF gotchas
└── assets/
    ├── premium-ebook.css               # production CSS, HTML→PDF + EPUB
    ├── chapter-template.html           # semantic chapter reference
    └── design-tokens.json              # tokens source of truth
```

## Deliverable contract

Every finished book ships exactly four files in `output/`:

| File | Purpose |
|---|---|
| `<book-slug>.html` | Interior, single-file with embedded CSS |
| `<book-slug>.pdf` | Interior at the chosen trim |
| `<book-slug>-cover.html` | Cover source |
| `<book-slug>-cover.png` | Cover at 1600×2560 (Apple/Kindle standard) |

No cover PDF — every store accepts the PNG. See `references/rendering.md` for the chromium headless commands and the `@page margin: 0` gotcha that, if missed, doubles the interior PDF page count.

---

## Install

### As a user-level skill (available in every Claude Code session)

```bash
git clone https://github.com/<you>/ebook-creation ~/.claude/skills/ebook-creation
```

### As a project-level skill (only inside one project)

```bash
git clone https://github.com/<you>/ebook-creation .claude/skills/ebook-creation
```

Restart Claude Code (or run `/help` and check the skills list). The skill name `ebook-creation` should appear.

> Claude Code's Agent Skills spec loads `SKILL.md` automatically and pulls in `references/*.md` only when the skill judges them relevant. Total baseline cost is ~100 tokens until a reference is needed.

---

## Use

### Easy — let it auto-trigger

Just describe what you're doing. The skill is registered to fire on phrases like:

- "Help me design a premium ebook."
- "Make this manuscript look expensive."
- "I want Apple Books quality typography."
- "Design a chapter opener with a drop cap."
- "Audit this book before I publish."
- "Build a design system for my book."

You don't need to invoke the skill by name.

### Explicit — invoke by name

In Claude Code:

```
/ebook-creation
```

or just say "use the ebook-creation skill".

### What it will do, in order

When the skill loads, it walks through this workflow before producing output:

1. **Three intake questions** — genre, trim size, one mood adjective. Non-negotiable; premium work needs them.
2. **Propose a design system** — type pair, color tokens, spacing scale. Wait for a yes.
3. **Build one sample chapter end-to-end** — opener, body, pull quote, figure, end mark. Wait for a yes.
4. **Mass-produce** the rest of the book in the approved system.
5. **Run the QA checklist** before declaring the book finished.

Anti-patterns it will refuse: skipping the intake, skipping the sample chapter, suggesting more than two typefaces, generating filler content from a thin brief, or using Puppeteer's native `page.pdf()` for designed ebooks.

---

## Use the assets directly (no Claude needed)

The three files in `assets/` are usable on their own.

### `premium-ebook.css`

Drop into your HTML book project:

```html
<link rel="stylesheet" href="path/to/premium-ebook.css">
<body data-mode="instructional"> <!-- or "narrative" -->
```

Modes:
- `data-mode="instructional"` — paragraph spacing, no first-line indent. Use for non-fiction, how-to, business.
- `data-mode="narrative"` — first-line indent, no paragraph spacing. Use for fiction, memoir.

The stylesheet covers `@page` rules for HTML→PDF (Puppeteer screenshot workflow), reflowable EPUB, dark mode, and print refinement.

### `chapter-template.html`

A complete chapter with every component the skill knows about — opener, eyebrow, drop cap, lead, section break, pull quote, callout, figure, block quote, table, footnote, end mark. Uses semantic HTML and EPUB 3 / DPUB-ARIA roles. Copy it as the starting point for chapter 1, then duplicate.

### `design-tokens.json`

Source of truth for color, type, spacing, page grid. If you change a token here, update `premium-ebook.css` to match (custom properties at the top of the file mirror the JSON).

Default palette is "Editorial" — warm off-white paper, dark warm ink, deep red accent. Other palettes (modern minimalist, warm narrative, dark) are documented in `references/design-system.md`.

---

## The 10 premium principles

Distilled from `SKILL.md`. Override these only with reason.

1. One typeface decision, executed perfectly, beats five "creative" choices.
2. Whitespace is the product.
3. Hierarchy through size and spacing, not bold or color.
4. Color is for emphasis, not decoration. One ink + one accent + two neutrals.
5. The reader should never see the grid, but should feel it.
6. Front matter is the trailer. Compose every page.
7. The cover is one decision; the spine is another; the back is a third.
8. Accessibility is not optional — and produces premium-quality output by default.
9. No emoji, no clip art, no stock photography that looks like stock.
10. Read it on a phone before you ship it.

---

## Pairing with `ebook-publishing`

This skill stops at a finished book. The publishing skill takes over for everything downstream:

| Stage | Skill |
|---|---|
| Brief, design system, manuscript, interior design, QA | **ebook-creation** (this one) |
| Format conversion, KDP/Apple/Gumroad upload, ISBN strategy, audiobook production, launch and promotion | **ebook-publishing** |

When both are installed, Claude Code will route the right one based on what you're asking about.

---

## Compatibility

- **Claude Code** ≥ the version that supports the Agent Skills spec.
- **EPUB 3** for the chapter template's semantic roles. EPUB 2 readers will fall back to plain HTML.
- **HTML→PDF** via Puppeteer screenshot workflow (recommended). Native `page.pdf()` and WeasyPrint are explicitly **not** supported for designed ebooks — both fail on drop caps, pull quotes, and `@page` running heads.
- **Webfonts** — the CSS lists font-family stacks ending in system fallbacks, so nothing breaks if you don't load EB Garamond / Inter. For premium output, host the webfonts and serve them with `font-display: swap`.

---

## Roadmap (open ideas)

- A second palette set inspired by photography monographs.
- An `art-book` mode of the CSS with full-bleed image rules and oversized trim defaults.
- A linter that scans HTML chapters against the QA checklist programmatically.
- More chapter templates — fiction (no callouts/tables), poetry (centered, asymmetric), workbook (with form fields).

PRs welcome.

---

## Contributing

- Don't expand the SKILL.md frontmatter description casually. Every keyword in there is a routing trigger.
- Keep reference files independently readable. A reader of `typography.md` should never need `interior-design.md` to understand a single answer.
- Keep `design-tokens.json` and `premium-ebook.css` in sync. If you add a token, add a custom property and a usage.
- New platform/royalty/specifications data should cite official platform docs (not blog posts) and update the file's date stamp.

---

## License

MIT — do anything you want, but ship something good.

---

## Credits

Built as a companion to the upstream [ebook-publishing-skill](https://github.com/arturseo-geo/ebook-publishing-skill) by Artur Ferreira / The GEO Lab. The two skills are designed to be used together but are independently maintainable.
