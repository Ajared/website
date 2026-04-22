# Ajared Research Inc

Static website for [ajared.ca](https://ajared.ca). 

Ajared is an AI research and product studio helping enterprises move from AI proof-of-concept to production-ready solutions. The site presents the studio's capabilities, past work, and a direct inquiry form.

## Architecture & Editing

The site uses a simple, dependency-free **XML + XSLT pipeline** to separate content from presentation. 

There is **no build step required for local authoring**. All layouts, styling, components, and logic are centralized in `site-renderer.xslt`. Page content is authored in semantic `.xml` files.

### How to Edit Content
1. **Never edit the `.html` files directly.** They are entirely generated.
2. Open the corresponding `.xml` file (e.g., `index.xml` or `capabilities/001-applied-research.xml`).
3. Modify the text inside the semantic tags (e.g. `<Title>`, `<Description>`).
4. **To preview live:** Open the `.xml` file directly in any modern web browser. The browser's native XSLT engine will download `site-renderer.xslt` and render the page instantly.

### Deployment & Build Step
When you are ready to deploy your changes, simply create a Git commit. 

The repository includes a Git `pre-commit` hook that automatically runs `./scripts/build.sh`. This script uses `xsltproc` to compile all `.xml` files into static `.html` files and bundles them into your commit for fast, secure hosting on GitHub Pages.

---

## Sitemap

```
ajared.ca/
├── site-renderer.xslt                       # Single source of truth for all CSS, layout, and rendering logic
├── index.xml                                # Homepage
├── contact/index.xml                        # Contact form and advisory booking
├── case-studies/index.xml                   # Case Studies archive
├── capabilities/index.xml                   # Capabilities overview
│   ├── 001-applied-research.xml             # Service Detail
│   ├── 002-ai-product.xml                   # Service Detail
│   ├── 003-enterprise-agents.xml            # Service Detail
│   └── 004-data-strategy.xml                # Service Detail
├── ai-readiness/index.xml                   # AI Readiness landing page
├── ai-sprint/index.xml                      # AI Sprint offering page
├── deliverables/index.xml                   # Deliverables hub
│   ├── 01_AI_Opportunity_Audit_Worksheet.html
│   ├── 02_Whats_Actually_Working_AI_Briefing.html
│   ├── 03_AI_Prompt_Starter_Kit.html
│   ├── 04_AI_Landscape_Mindmap.html
│   └── 05_Post_Call_Action_Plan.html
├── talk/index.xml                           # Talk / speaking page
│   └── prep/index.html                      # Talk prep (static, no XML source)
├── scripts/                                 # Page-specific JS logic
│   ├── build.sh                             # XSLT compiler script
│   ├── accordion.js                         # Capabilities toggle logic
│   ├── contact.js                           # Contact map and deliverables logic
│   ├── sprint.js                            # AI Sprint page logic
│   └── moire.js, cap-moire.js, cap-detail-moire.js   # Hero canvas effects
```

---

## Stack

- **Content**: Semantic XML (`.xml`)
- **Presentation/Logic**: XSLT 1.0 (`site-renderer.xslt`), Vanilla CSS, Vanilla JS
- **Compiler**: `xsltproc` (Unix standard)
- **Typography:** [iA Writer Quattro S](https://github.com/iaolo/iA-Fonts)
- **Forms:** [Formspree](https://formspree.io)
- **Hosting:** GitHub Pages
