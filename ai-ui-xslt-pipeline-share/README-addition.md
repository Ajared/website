# README addition — paste this section into the main README.md

Add this as a new section, after the "How it works" section and before any license/footer content.

---

## Using with Claude (AI skill)

A Claude skill is included in the `claude-skill/` folder. It teaches Claude the component vocabulary, design token system, and XSLT patterns for this pipeline — so you can build and iterate on the UI using plain language.

**Install:** Download `claude-skill/xslt-ui-pipeline.skill` and double-click it in Claude desktop (Cowork mode required, currently in beta).

**Then just describe what you want:**

```
"Add a Recent Messages section with sender, preview, and timestamp"
"Change the accent color to coral"
"Add stat boxes for steps, calories, and sleep"
```

Claude will produce correctly structured XML and XSLT — new components will use `var(--color-terra)` and the existing design tokens rather than hardcoding values, keeping the design system intact.

See [`claude-skill/README.md`](claude-skill/README.md) for full details and installation instructions.

---
