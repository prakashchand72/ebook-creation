# Typography

Type is 80% of the perceived quality of a book. Get this right and the rest is polish.

## The pair

A premium ebook uses **at most two typefaces**: one for body, one for display/UI. A third "accent" face (e.g. a monospace for code, an italic script for epigraphs) is allowed only if the book genuinely needs it.

### Body face — pick one

| Face | License | Why |
|---|---|---|
| **EB Garamond** | OFL (free) | The default premium body face. Open apertures, classic feel, excellent on screen. |
| **Source Serif 4** | OFL (free) | Modern, slightly tighter than Garamond. Good for non-fiction. |
| **Crimson Pro** | OFL (free) | Warmer than Source Serif. Good for memoir, narrative non-fiction. |
| **Lora** | OFL (free) | Friendly, slightly looser. Good for self-help, lifestyle. |
| **Tiempos Text** | Klim (paid) | If budget allows, this is the gold standard for editorial. |
| **Charter** | Free (Bitstream) | Ships on macOS/iOS — guaranteed render on Apple Books. |

**Rules:**
- No Times New Roman. No Georgia. They render fine but signal default-settings.
- No display serifs (Playfair, DM Serif Display) in body — they break at small sizes.

### Display face — pick one

| Face | License | Why |
|---|---|---|
| **Inter** | OFL (free) | Neutral, professional, doesn't fight the body serif. Good for non-fiction. |
| **Söhne** | Klim (paid) | If budget allows. The face that makes everything look expensive. |
| **National 2** | Klim (paid) | Editorial-feeling sans, slightly softer than Söhne. |
| **GT America** | Grilli Type (paid) | Highly versatile for art books and lookbooks. |
| **Söhne Mono / JetBrains Mono / IBM Plex Mono** | OFL or paid | Code blocks only. |

**Rules:**
- No Helvetica/Arial. They render fine but signal default-settings.
- No Montserrat, Poppins, Raleway, Open Sans. These are the giveaway fonts of cheap design.

### Avoid entirely

Comic Sans, Papyrus, Brush Script, Lobster, Pacifico, Bebas Neue, Anton, any "free wedding font", any handwriting font that isn't a paid commission.

## Size scale

Use a **modular scale** with a ratio of 1.2 (minor third) for non-fiction and 1.25 (major third) for art books / lookbooks.

Base body: **11pt for print, 17px for ebook reading apps, 18px for HTML→PDF rendered at 1.5×.**

Generated scale at 1.2 ratio (rounded to nearest 0.5pt):

| Token | Print (pt) | Web (rem, base 1rem = 17px) | Use |
|---|---|---|---|
| `--type-xs` | 9 | 0.694 | Captions, footnotes |
| `--type-sm` | 10 | 0.833 | Folios, running heads |
| `--type-base` | 11 | 1.000 | Body |
| `--type-md` | 13 | 1.200 | Pull quotes, lead paragraphs |
| `--type-lg` | 15.5 | 1.440 | H4, sidebar headings |
| `--type-xl` | 18.5 | 1.728 | H3 |
| `--type-2xl` | 22 | 2.074 | H2 (section break) |
| `--type-3xl` | 26.5 | 2.488 | H1 (chapter title) |
| `--type-display` | 38 | 3.583 | Chapter number, part opener |

## Line height (leading)

- **Body**: 1.55–1.65. Lower than 1.5 looks cramped; higher than 1.7 looks airy/blog-like.
- **Headings**: 1.1–1.25. Tight.
- **Pull quotes**: 1.35.
- **Captions**: 1.4.

## Measure (line length)

The single most violated rule in self-published ebooks.

- **Optimal: 60–75 characters per line, including spaces.** Roughly 10–12 words.
- For body copy at 17px Inter equivalent, that's a `max-width` of about **34rem / 540px**.
- Never set body to full container width on a wide screen. Center the text column.

```css
.chapter__body { max-width: 34rem; margin-inline: auto; }
```

## Hierarchy without bold

Premium books rarely use **bold** in body copy. They use:

- Size (the scale above)
- Space (more space above and below = more important)
- Case (small caps for section labels: `font-variant: small-caps; letter-spacing: 0.06em;`)
- Italic (for emphasis within a sentence — but at most once per paragraph)
- Position (centered, hung in the margin, set on its own line)

If you find yourself reaching for `<strong>` in body, it's usually a sign the sentence needs rewriting, not styling.

## Indents vs paragraph spacing

**Pick one. Never both.**

- **Fiction, narrative non-fiction, memoir** → first-line indent of `1em`, no paragraph spacing. The first paragraph of a chapter (or after a scene break) is **not** indented.
- **How-to, business, technical, self-help** → no indent, `0.75em` paragraph spacing.

```css
/* Narrative */
.chapter__body p { text-indent: 1em; }
.chapter__body p:first-of-type,
.chapter__body p.no-indent { text-indent: 0; }

/* Instructional */
.chapter__body p { margin-block-end: 0.75em; }
```

## OpenType features

If the body face supports them, turn these on:

```css
font-feature-settings: "kern" 1, "liga" 1, "dlig" 0, "onum" 1, "tnum" 0;
font-variant-numeric: oldstyle-nums proportional-nums;
```

- `onum` (oldstyle figures) for numbers in flowing text — they don't shout.
- `tnum` (tabular figures) only inside tables/lists where digits must align.
- `dlig` (discretionary ligatures) **off** — they're decorative and slow reading.

## Hyphenation and justification

```css
.chapter__body p {
  text-align: justify;
  hyphens: auto;
  hyphenate-limit-chars: 6 3 3;
  hyphenate-limit-lines: 2;
}
```

- Justify only when hyphenation is on. Justified text without hyphenation produces "rivers" of white space — the cheapest-looking thing in typography.
- For ebooks rendered in Apple Books / Kindle, the reader's app controls this; for HTML→PDF, you control it.

## Drop caps

A drop cap is a luxury signal — but only when done correctly.

- 3 lines tall, never 4+.
- Same face as the body, not the display.
- Optical kerning against the second character (the hardest part — manual `margin-right` adjustment per letter).
- The first **3–5 words after the drop cap** should be in small caps. This is the rhythm: huge letter → small caps → body. Without the small caps it looks unfinished.

```css
.chapter__body > p:first-of-type::first-letter {
  float: left;
  font-size: 4.2em;
  line-height: 0.9;
  margin: 0.05em 0.08em -0.05em 0;
  font-weight: 400;
}
.chapter__body > p:first-of-type::first-line {
  font-variant: small-caps;
  letter-spacing: 0.06em;
}
```

(The `::first-line` trick gives you the small-caps run-in without manual span-wrapping.)

## What to test before signing off on type

- Body at 100% zoom on a phone (375px). Does the line length feel right?
- Body in dark mode (Apple Books invert, Kindle sepia/dark). Does the contrast still pass 4.5:1?
- Numbers inside a paragraph. Are they oldstyle (look like lowercase letters) or lining (uppercase-height)? They should be oldstyle in body.
- One full chapter printed at trim size. Hold it at arm's length. Squint. Does the page have a clear shape, or is it a gray block?
