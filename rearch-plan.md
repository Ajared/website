# Site Rearchitecture Plan — XML + XSLT Pipeline
Branch: `rearch`

---

## Goal

Replace the current plain HTML pages with an XML + XSLT pipeline, so that:
- **Content** lives in `.xml` files (one per page) — the only files ever edited day-to-day
- **Layout and styling** lives in `site-renderer.xslt` — edited only when the design changes
- **Preview** works by opening any `.xml` file in a browser — no build step, no server needed
- The workflow matches how the ai-ui-xslt-pipeline skill already operates

---

## Current Structure (plain HTML)

```
site/
├── index.html
├── capabilities/
│   ├── index.html
│   ├── 001-applied-research.html
│   ├── 002-ai-product.html
│   ├── 003-enterprise-agents.html
│   └── 004-data-strategy.html
├── case-studies/
│   └── index.html
└── contact/
    └── index.html
```

---

## Target Structure (XML + XSLT)

```
site/
├── site-renderer.xslt          ← single shared renderer for all pages
├── index.xml                   ← replaces index.html (content only)
├── index.html                  ← generated output (or kept for GH Pages compat)
├── capabilities/
│   ├── index.xml
│   ├── 001-applied-research.xml
│   ├── 002-ai-product.xml
│   ├── 003-enterprise-agents.xml
│   └── 004-data-strategy.xml
├── case-studies/
│   └── index.xml
└── contact/
    └── index.xml
```

Each `.xml` file begins with:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="/site-renderer.xslt"?>
<Page id="index">
  ...
</Page>
```

The browser applies the XSLT transformation natively — open the `.xml` directly and you see the rendered page.

---

## XML Component Vocabulary (to be designed)

These are the building blocks that `site-renderer.xslt` will know how to render.
Mirrors the existing HTML structure of the site.

### Global components (every page)

```xml
<Header>
  <Logo />
  <CoordCell city="Toronto" lat="43.6332° N" lng="79.4141° W" />
  <CoordCell city="Abuja" lat="8.9976° N" lng="7.4674° E" />
  <Nav active="index" />         <!-- active attr highlights current page -->
</Header>

<Footer email="innovation@ajared.ca" year="2026" />
```

### Page-specific components

**Hero (index)**
```xml
<Hero label="AI Research & Product Studio">
  <Headline>Get AI<br/>working<br/>for you<br/>today.</Headline>
  <Sub>We go past proofs of concept...</Sub>
  <CTA href="/contact/">Get in touch →</CTA>
</Hero>
```

**OfferGrid (index)**
```xml
<OfferGrid>
  <Offer number="01" tag="Advisory" title="Talk to a Human about AI" href="/contact/">
    Not a chatbot. A real conversation with early adopters...
  </Offer>
  <Offer number="02" tag="Build" title="1 Month AI Development Sprint" href="/contact/">
    A focused, time-boxed build...
  </Offer>
  <Offer number="03" tag="Learn" title="Get Started with AI" href="/contact/">
    <Tracks>
      <Track n="01">Using an assistant</Track>
      <Track n="02">Adding Tool Use</Track>
      <Track n="03">Agentic Workflows</Track>
    </Tracks>
  </Offer>
  <Offer number="04" tag="AI Search" title="Help AI Agents easily find your brand" href="/contact/">
    AI agents are how people will discover you next...
  </Offer>
</OfferGrid>
```

**CapabilityAccordion (capabilities/index)**
```xml
<CapabilityList>
  <Capability number="001" title="Applied Research" subtitle="How We Learn What's True"
              href="/capabilities/001-applied-research.html">
    <InBrief>We talk to your users, study your market...</InBrief>
    <Overview>We figure out what's actually going on...</Overview>
    <Tags label="Methods">
      <Tag>UX Research</Tag>
      <Tag>Market Research</Tag>
      <Tag>Experimental Design</Tag>
      <Tag>Meta-Analysis</Tag>
    </Tags>
    <Meta duration="8–16 weeks" team="2–4 researchers" />
  </Capability>
  <!-- ...003, 003, 004 -->
</CapabilityList>
```

**CapabilityPage (001-applied-research, etc.)**
```xml
<CapabilityPage number="001" title="Applied Research">
  <Section title="What We Do">...</Section>
  <Section title="How We Work">...</Section>
  <!-- etc -->
</CapabilityPage>
```

---

## Implementation Sequence

### Phase 1 — Scaffold (branch: `rearch`)
1. Create `site-renderer.xslt` with global templates: `<Header>`, `<Footer>`, `<Nav>`, shared CSS custom properties, fonts, grid system
2. Write `index.xml` using the new vocabulary
3. Verify: open `index.xml` in browser → rendered page matches current `index.html` exactly

### Phase 2 — Page by page
Migrate each page in order of complexity (simplest first):

| Order | Page | Complexity |
|-------|------|-----------|
| 1 | `contact/index` | Minimal content |
| 2 | `case-studies/index` | Static layout |
| 3 | `index` | Offer grid, moiré hero |
| 4 | `capabilities/index` | Accordion, accordion JS |
| 5 | `capabilities/001–004` | Repeating structure, good template candidate |

For each page:
- Write the `.xml` file
- Add any new XSLT templates needed to `site-renderer.xslt`
- Screenshot to confirm visual match
- Keep old `.html` file until all pages migrated

### Phase 3 — GitHub Pages compatibility
GitHub Pages serves files directly — it won't apply XSLT. Two options:

**Option A: Keep both**
- `.xml` is the source of truth (edited by Claude)
- `.html` is generated from it via a build step (`xsltproc` or a small Node script)
- Run generation before every commit

**Option B: Inline the XSLT**
- Each `.xml` references the renderer via `<?xml-stylesheet?>`
- Rename `.xml` → `.html` and serve as-is (browsers handle it natively)
- Requires server to send correct `Content-Type: application/xml` header — not possible on GH Pages

**Recommended: Option A**
Use `xsltproc` (available on Linux/macOS) to generate `.html` from `.xml` before commit:
```bash
xsltproc site-renderer.xslt index.xml > index.html
```
Claude runs this step at the end of each editing session.

### Phase 4 — Cleanup
- Remove old `.html` source files (keep only generated ones)
- Update skill description to reference `site-renderer.xslt` and the new vocabulary
- Document the new edit-preview-generate-commit workflow

---

## The New Daily Workflow (once complete)

```
1. Claude edits content.xml
2. Open .xml in browser → instant preview (no server needed)
3. Iterate until satisfied
4. Claude runs: xsltproc site-renderer.xslt page.xml > page.html
5. Commit both .xml and generated .html
```

---

## Open Decisions (resolve before starting Phase 1)

1. **Option A or B for GH Pages?** — Recommendation is A (xsltproc generation)
2. **Shared renderer or per-section renderers?** — One `site-renderer.xslt` is simpler; per-section (capabilities-renderer.xslt etc.) is more modular but adds complexity
3. **JS (moiré, accordion) — embed in XSLT or external `.js` files?** — External `.js` is cleaner; XSLT can `<script src="...">` just like HTML

---

## Estimated Effort

| Phase | Sessions |
|-------|---------|
| Phase 1 — Scaffold + index | 1 session |
| Phase 2 — All pages | 2–3 sessions |
| Phase 3 — GH Pages build step | 1 session |
| Phase 4 — Cleanup + docs | 1 session |
