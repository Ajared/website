# Schema.org JSON-LD Markup Plan — ajared.ca

**Prepared:** March 2026
**Site:** https://ajared.ca
**Company:** Ajared Research Inc.

---

## Overview

This plan outlines structured data markup to be added to each page of ajared.ca using the JSON-LD format embedded in `<script type="application/ld+json">` tags placed in the `<head>` of each HTML file. The goal is to improve search engine understanding of the business, its services, and its content — enabling rich results and better entity disambiguation in Google Search.

---

## Sitewide Baseline (add to every page)

Two schemas apply globally and should appear on every page.

### 1. `Organization`

This is the most important schema. It establishes Ajared Research Inc. as a known entity with consistent identity signals across all pages.

```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "@id": "https://ajared.ca/#organization",
  "name": "Ajared Research Inc.",
  "url": "https://ajared.ca",
  "logo": "https://ajared.ca/logo.png",
  "description": "An AI research and product studio helping enterprises move from AI proof-of-concept to production-ready solutions.",
  "email": "innovation@ajared.ca",
  "sameAs": ["https://ajared.ng"],
  "location": [
    {
      "@type": "Place",
      "name": "Toronto",
      "address": {
        "@type": "PostalAddress",
        "addressLocality": "Toronto",
        "addressRegion": "Ontario",
        "addressCountry": "CA"
      }
    },
    {
      "@type": "Place",
      "name": "Abuja",
      "address": {
        "@type": "PostalAddress",
        "addressLocality": "Abuja",
        "addressCountry": "NG"
      }
    }
  ],
  "knowsAbout": [
    "Artificial Intelligence",
    "Applied Research",
    "AI Product Development",
    "Enterprise AI Agents",
    "Data Strategy"
  ]
}
```

**Notes:**
- `@id` uses a canonical URI with a fragment — this is the standard way to create a referenceable entity ID across pages.
- Add real social profile URLs to `sameAs` when available (LinkedIn, GitHub, etc.).
- `location` uses an array since the company has two offices.

### 2. `WebSite`

Enables the Sitelinks Search Box if Google decides to show it, and signals the canonical home URL.

```json
{
  "@context": "https://schema.org",
  "@type": "WebSite",
  "@id": "https://ajared.ca/#website",
  "url": "https://ajared.ca",
  "name": "Ajared Research Inc.",
  "publisher": {
    "@id": "https://ajared.ca/#organization"
  }
}
```

---

## Page-by-Page Plan

### Homepage — `index.html`

**Schemas to add:** `Organization` (sitewide) + `WebSite` (sitewide) + `ProfessionalService`

The homepage is where the company introduces its four service areas. Adding a `ProfessionalService` node (a subtype of `LocalBusiness`) strengthens the entity and makes service categories discoverable.

```json
{
  "@context": "https://schema.org",
  "@type": "ProfessionalService",
  "@id": "https://ajared.ca/#service",
  "name": "Ajared Research Inc.",
  "url": "https://ajared.ca",
  "description": "Applied AI research and product studio delivering enterprise AI solutions.",
  "hasOfferCatalog": {
    "@type": "OfferCatalog",
    "name": "AI Services",
    "itemListElement": [
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "Applied Research",
          "url": "https://ajared.ca/capabilities/001-applied-research.html"
        }
      },
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "AI Product Development & Management",
          "url": "https://ajared.ca/capabilities/002-ai-product.html"
        }
      },
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "Enterprise AI Agents",
          "url": "https://ajared.ca/capabilities/003-enterprise-agents.html"
        }
      },
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "Data and AI Strategy",
          "url": "https://ajared.ca/capabilities/004-data-strategy.html"
        }
      }
    ]
  }
}
```

---

### Capabilities Index — `capabilities/index.html`

**Schemas to add:** Sitewide + `BreadcrumbList` + `ItemList`

The capabilities index is a listing page. `ItemList` signals to Google that this is a structured catalogue of services.

```json
{
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [
    {
      "@type": "ListItem",
      "position": 1,
      "name": "Home",
      "item": "https://ajared.ca"
    },
    {
      "@type": "ListItem",
      "position": 2,
      "name": "Capabilities",
      "item": "https://ajared.ca/capabilities/"
    }
  ]
}
```

```json
{
  "@context": "https://schema.org",
  "@type": "ItemList",
  "name": "Ajared Research Capabilities",
  "description": "The four core service disciplines offered by Ajared Research Inc.",
  "itemListElement": [
    {
      "@type": "ListItem",
      "position": 1,
      "url": "https://ajared.ca/capabilities/001-applied-research.html",
      "name": "Applied Research"
    },
    {
      "@type": "ListItem",
      "position": 2,
      "url": "https://ajared.ca/capabilities/002-ai-product.html",
      "name": "AI Product Development & Management"
    },
    {
      "@type": "ListItem",
      "position": 3,
      "url": "https://ajared.ca/capabilities/003-enterprise-agents.html",
      "name": "Enterprise AI Agents"
    },
    {
      "@type": "ListItem",
      "position": 4,
      "url": "https://ajared.ca/capabilities/004-data-strategy.html",
      "name": "Data and AI Strategy"
    }
  ]
}
```

---

### Capability Detail Pages

Each of the four capability pages gets its own `Service` schema plus a `BreadcrumbList`. The pattern is the same for all four — only the specifics change.

#### `001-applied-research.html`

```json
{
  "@context": "https://schema.org",
  "@type": "Service",
  "@id": "https://ajared.ca/capabilities/001-applied-research.html#service",
  "name": "Applied Research",
  "alternateName": "How We Learn What's True",
  "description": "User studies, market analysis, and experimentation to validate concepts before development begins. Methods include UX research, behavioral science, statistical analysis, and evidence synthesis.",
  "provider": { "@id": "https://ajared.ca/#organization" },
  "url": "https://ajared.ca/capabilities/001-applied-research.html",
  "serviceType": "Applied Research",
  "category": "Research Services",
  "areaServed": ["CA", "NG"],
  "offers": {
    "@type": "Offer",
    "availability": "https://schema.org/InStock",
    "areaServed": ["CA", "NG"]
  }
}
```

```json
{
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [
    { "@type": "ListItem", "position": 1, "name": "Home", "item": "https://ajared.ca" },
    { "@type": "ListItem", "position": 2, "name": "Capabilities", "item": "https://ajared.ca/capabilities/" },
    { "@type": "ListItem", "position": 3, "name": "Applied Research", "item": "https://ajared.ca/capabilities/001-applied-research.html" }
  ]
}
```

#### `002-ai-product.html`

```json
{
  "@context": "https://schema.org",
  "@type": "Service",
  "@id": "https://ajared.ca/capabilities/002-ai-product.html#service",
  "name": "AI Product Development & Management",
  "alternateName": "Strategy & Delivery",
  "description": "Full lifecycle AI product development from concept through launch and optimization. Covers product strategy, roadmap planning, model selection, launch coordination, and performance analytics.",
  "provider": { "@id": "https://ajared.ca/#organization" },
  "url": "https://ajared.ca/capabilities/002-ai-product.html",
  "serviceType": "AI Product Development",
  "category": "Technology Services",
  "areaServed": ["CA", "NG"]
}
```

Breadcrumb follows the same pattern with position 3 set to "AI Product Development & Management".

#### `003-enterprise-agents.html`

```json
{
  "@context": "https://schema.org",
  "@type": "Service",
  "@id": "https://ajared.ca/capabilities/003-enterprise-agents.html#service",
  "name": "Enterprise AI Agents",
  "alternateName": "Autonomous AI Systems",
  "description": "Design and deployment of autonomous AI agents that automate document processing, inter-system coordination, and routine decision-making. Includes agent architecture, RAG systems, and multi-agent coordination.",
  "provider": { "@id": "https://ajared.ca/#organization" },
  "url": "https://ajared.ca/capabilities/003-enterprise-agents.html",
  "serviceType": "Enterprise AI Automation",
  "category": "Technology Services",
  "areaServed": ["CA", "NG"]
}
```

#### `004-data-strategy.html`

```json
{
  "@context": "https://schema.org",
  "@type": "Service",
  "@id": "https://ajared.ca/capabilities/004-data-strategy.html#service",
  "name": "Data and AI Strategy",
  "alternateName": "Governance, Advisory and Adoption",
  "description": "Strategic consulting covering data asset audits, AI readiness assessments, governance frameworks, and organizational adoption roadmaps.",
  "provider": { "@id": "https://ajared.ca/#organization" },
  "url": "https://ajared.ca/capabilities/004-data-strategy.html",
  "serviceType": "Data & AI Strategy",
  "category": "Consulting Services",
  "areaServed": ["CA", "NG"]
}
```

---

### Case Studies — `case-studies/index.html`

**Schemas to add:** Sitewide + `BreadcrumbList` + `ItemList` + individual `Article` per case study

As the case study library grows, each entry should get its own `Article` (or `TechArticle`) schema. For now, with one case study (DeckSense), the block looks like this:

```json
{
  "@context": "https://schema.org",
  "@type": "ItemList",
  "name": "Ajared Research Case Studies",
  "itemListElement": [
    {
      "@type": "ListItem",
      "position": 1,
      "url": "https://ajared.ca/case-studies/#decksense",
      "name": "DeckSense — AI Product Management"
    }
  ]
}
```

```json
{
  "@context": "https://schema.org",
  "@type": "TechArticle",
  "headline": "DeckSense AI Product Management",
  "description": "A case study by Ajared Research Inc. on the development and deployment of DeckSense, an AI product management application.",
  "author": { "@id": "https://ajared.ca/#organization" },
  "publisher": { "@id": "https://ajared.ca/#organization" },
  "datePublished": "2025",
  "url": "https://ajared.ca/case-studies/",
  "about": {
    "@type": "Thing",
    "name": "AI Product Management"
  }
}
```

**Note:** When individual case study pages are added, move each `TechArticle` to its own dedicated URL and populate `datePublished` with an ISO 8601 date (e.g. `"2025-06-01"`).

---

### Contact — `contact/index.html`

**Schemas to add:** Sitewide + `ContactPage`

```json
{
  "@context": "https://schema.org",
  "@type": "ContactPage",
  "name": "Contact Ajared Research Inc.",
  "url": "https://ajared.ca/contact/",
  "description": "Reach Ajared Research Inc. for inquiries about AI research, product development, enterprise agents, and data strategy engagements.",
  "mainEntity": { "@id": "https://ajared.ca/#organization" }
}
```

---

## Implementation Checklist

| Page | Organization | WebSite | Page-specific schema | BreadcrumbList |
|---|---|---|---|---|
| `index.html` | ✓ | ✓ | `ProfessionalService` | — |
| `capabilities/index.html` | ✓ | — | `ItemList` | ✓ |
| `capabilities/001-applied-research.html` | ✓ | — | `Service` | ✓ |
| `capabilities/002-ai-product.html` | ✓ | — | `Service` | ✓ |
| `capabilities/003-enterprise-agents.html` | ✓ | — | `Service` | ✓ |
| `capabilities/004-data-strategy.html` | ✓ | — | `Service` | ✓ |
| `case-studies/index.html` | ✓ | — | `ItemList` + `TechArticle` | ✓ |
| `contact/index.html` | ✓ | — | `ContactPage` | ✓ |

---

## Implementation Approach

Each JSON-LD block should be placed inside a `<script>` tag in the `<head>` section of the HTML file:

```html
<script type="application/ld+json">
{ ... schema here ... }
</script>
```

Multiple schemas on a single page can be implemented as separate `<script>` blocks (preferred for readability) or as a single block using a `@graph` array:

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@graph": [
    { ... schema 1 ... },
    { ... schema 2 ... }
  ]
}
</script>
```

The `@graph` approach is recommended for production since it's more maintainable and allows entity references to be resolved within the same document.

---

## Validation

After implementation, validate each page using:

- **Google's Rich Results Test:** https://search.google.com/test/rich-results
- **Schema.org Validator:** https://validator.schema.org
- **Google Search Console → Enhancements tab** (after deployment) for any crawl-time errors

---

## Future Schema Opportunities

As the site evolves, consider adding:

- `FAQPage` — if a FAQ section is added to any page
- `Review` / `AggregateRating` — if client testimonials are added
- `Event` — for any workshops, webinars, or speaking engagements
- `JobPosting` — if a careers section is created
- `Person` — for team member profile pages
- `CreativeWork` / `SoftwareApplication` — if Ajared publishes tools or open-source projects
