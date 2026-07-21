<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" doctype-system="about:legacy-compat" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>

  <!-- Root template -->
  <xsl:template match="/Page">
    <html lang="en">
      <head>
        <!-- Google Tag Manager -->
        <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&amp;l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-5TQXWR2M');</script>
        <!-- End Google Tag Manager -->
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="icon" type="image/x-icon" href="/favicon.ico"/>
        <link rel="icon" type="image/svg+xml" href="/favicon.svg"/>
        <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png"/>
        <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png"/>
        <link rel="apple-touch-icon" sizes="180x180" href="/favicon-32x32.png"/>
        <title><xsl:value-of select="@title" /> — Ajared Research Inc</title>
        <!-- SEO: meta description + Open Graph (set description and url attrs on <Page>) -->
        <xsl:if test="@description">
          <meta name="description"><xsl:attribute name="content"><xsl:value-of select="@description"/></xsl:attribute></meta>
        </xsl:if>
        <xsl:if test="@url">
          <meta property="og:type" content="website"/>
          <meta property="og:url"><xsl:attribute name="content"><xsl:value-of select="@url"/></xsl:attribute></meta>
          <meta property="og:title"><xsl:attribute name="content"><xsl:value-of select="@title"/> — Ajared Research Inc</xsl:attribute></meta>
          <xsl:if test="@description">
            <meta property="og:description"><xsl:attribute name="content"><xsl:value-of select="@description"/></xsl:attribute></meta>
          </xsl:if>
          <meta property="og:image" content="https://ajared.ca/social-card.png"/>
          <meta property="og:image:width" content="1200"/>
          <meta property="og:image:height" content="628"/>
          <meta name="twitter:card" content="summary_large_image"/>
          <meta name="twitter:title"><xsl:attribute name="content"><xsl:value-of select="@title"/> — Ajared Research Inc</xsl:attribute></meta>
          <xsl:if test="@description">
            <meta name="twitter:description"><xsl:attribute name="content"><xsl:value-of select="@description"/></xsl:attribute></meta>
          </xsl:if>
          <meta name="twitter:image" content="https://ajared.ca/social-card.png"/>
        </xsl:if>
        <!-- Google Search Console verification (replace XXXX with code from GSC) -->
        <!-- <meta name="google-site-verification" content="XXXX"/> -->
        <style>
        /* iA Writer Quattro S Font */
        @font-face {
            font-family: 'iA Writer Quattro S';
            src: url('/fonts/iAWriterQuattroS-Regular.woff2') format('woff2'),
                url('/fonts/iAWriterQuattroS-Regular.woff') format('woff');
            font-weight: 400;
            font-style: normal;
            font-display: swap;
        }

        @font-face {
            font-family: 'iA Writer Quattro S';
            src: url('/fonts/iAWriterQuattroS-Bold.woff2') format('woff2'),
                url('/fonts/iAWriterQuattroS-Bold.woff') format('woff');
            font-weight: 700;
            font-style: normal;
            font-display: swap;
        }

        @font-face {
            font-family: 'iA Writer Quattro S';
            src: url('/fonts/iAWriterQuattroS-Italic.woff2') format('woff2'),
                url('/fonts/iAWriterQuattroS-Italic.woff') format('woff');
            font-weight: 400;
            font-style: italic;
            font-display: swap;
        }

        :root {
            --color-bg: #ffffff;
            --color-ink: #058c8c;
            --color-ink-dark: #046363;
            --color-ink-darkest: #023b3b;
            --color-ink-light: #8ccaca;
            --color-ink-lighter: #b2dbdb;
            --color-neutral-dark: #323232;
            --color-terra: #a1665e;
            --grid-line: 1px solid var(--color-ink);
            --font-primary: 'iA Writer Quattro S', 'Helvetica Neue', Helvetica, Arial, sans-serif;
            --font-mono: 'iA Writer Quattro S', 'Courier New', monospace;
            --spacing-unit: 8px;
            --radius-sm: 2px;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            cursor: pointer;
        }

        a, button, input, select, textarea, label, .btn, .capability-header {
            cursor: crosshair;
        }

        body {
            background-color: var(--color-bg);
            color: var(--color-ink);
            font-family: var(--font-primary);
            overflow-x: hidden;
            width: 100vw;
            min-height: 100vh;
            -webkit-font-smoothing: antialiased;
        }

        h1,
        h2,
        h3,
        h4 {
            font-weight: 700;
            letter-spacing: -0.04em;
            line-height: 0.9;
            color: var(--color-ink-darkest);
        }

        h1 {
            font-size: clamp(4rem, 10vw, 9rem);
        }

        h2 {
            font-size: 2rem;
            margin-bottom: 1rem;
        }

        h3 {
            font-size: 1.5rem;
        }

        p {
            font-size: 1.1rem;
            line-height: 1.4;
            max-width: 36ch;
            font-weight: 400;
            color: var(--color-ink-dark);
        }

        .label {
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            margin-bottom: 0.5rem;
            display: block;
            color: var(--color-ink);
            font-family: var(--font-mono);
        }

        a {
            color: inherit;
            text-decoration: none;
        }

        /* Grid System */
        .grid-container {
            display: grid;
            grid-template-columns: 80px 1fr 1fr 1fr;
            min-height: 100vh;
            border-left: var(--grid-line);
            border-right: var(--grid-line);
            max-width: 1600px;
            margin: 0 auto;
            position: relative;
        }

        .ruler-y {
            width: 80px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 20px 0;
            font-family: var(--font-mono);
            font-size: 10px;
            text-align: right;
            padding-right: 8px;
            position: relative;
            background-image: linear-gradient(to bottom, var(--color-ink-light) 1px, transparent 1px);
            background-size: 100% 20px;
            color: var(--color-ink-light);
        }

        /* Change 9: Major interval tick labels (every 500px: 0, 500, 1000) get terra cotta */
        .ruler-y span:nth-child(5n+1) {
            color: var(--color-terra);
        }

        .ruler-x {
            height: 40px;
            width: 100%;
            border-bottom: var(--grid-line);
            display: flex;
            align-items: flex-end;
            background-image: linear-gradient(to right, var(--color-ink-light) 1px, transparent 1px);
            background-size: 20px 100%;
            font-family: var(--font-mono);
            font-size: 10px;
            padding-bottom: 4px;
            position: sticky;
            top: 0;
            z-index: 100;
            background-color: var(--color-bg);
        }

        .main-content {
            grid-column: 2 / -1;
            display: flex;
            flex-direction: column;
        }

        /* Header */
        header {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            border-bottom: var(--grid-line);
        }

        .header-cell {
            padding: 2rem;
            border-right: var(--grid-line);
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            gap: 0.75rem;
            min-height: 160px;
        }

        @media (max-width: 768px) {
            .form-section { grid-template-columns: 1fr; }
            .form-left { padding: 3rem 1rem; border-right: none; border-bottom: var(--grid-line); }
            .form-right { padding: 3rem 1rem; }
            .project-row { padding: 1.5rem 1.5rem; grid-template-columns: 40px 1fr; gap: 1rem; }
            .project-meta, .project-year { display: none; }
            .hero-fullbleed { height: 25vh; }
            .capability-header { padding: 1.5rem 1.5rem; grid-template-columns: 50px 1fr 50px; }
            .cap-subtitle { display: none; }
            .detail-inner { padding: 1.5rem 1.5rem; grid-template-columns: 1fr; }
            .detail-brief { grid-column: 1; }
            .detail-row-link { grid-column: 1; }
            .stats-bar { grid-template-columns: 1fr 1fr; }
            .stat-cell { padding: 1.5rem 1rem; }
            .stat-cell:nth-child(2) { border-right: none; }
            .nav-crumb { padding: 0; font-size: 0.58rem; }
            .hero-detail { padding: 2rem 1.2rem; }
            .hero-detail h1 { font-size: clamp(1.6rem, 8vw, 2.6rem); }
            .essay-section { grid-template-columns: 1fr; }
            .essay-main { border-right: none; border-bottom: var(--grid-line); padding: 1.2rem; }
            .sidenote { display: none; }
            .essay-section-label { padding: 0.65rem 1.2rem; }
            .cta-block { grid-template-columns: 1fr; gap: 1.2rem; padding: 1.8rem 1.2rem; }
            .cta-btn { text-align: center; display: block; }
            .cap-nav { grid-template-columns: 1fr 1fr; }
            .cap-nav-center { display: none; }
        }



        .header-cell:last-child {
            border-right: none;
        }

        .logo-text {
            font-size: 1.6rem;
            font-weight: 700;
            letter-spacing: -0.02em;
            color: var(--color-ink-darkest);
        }

        nav p {
            margin-bottom: 0.3rem;
            font-size: 1rem;
        }

        /* Change 11: Nav hover — terra cotta */
        nav a:hover {
            text-decoration: underline;
            color: var(--color-terra);
        }

        /* Hero */
        .hero-section {
            display: grid;
            grid-template-columns: 2fr 1fr;
            min-height: 70vh;
            border-bottom: var(--grid-line);
            position: relative;
            overflow: hidden;
        }

        .hero-text {
            padding: 3rem 2rem;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            position: relative;
            z-index: 2;
        }

        .hero-text p {
            transition: color 0.3s ease;
        }

        .hero-text p:hover {
            color: #a1665e;
        }

        .moire-container {
            width: 100%;
            height: 100%;
            position: absolute;
            overflow: hidden;
            top: 0;
            left: 0;
        }

        /* Refined, subtle ripple styling */
        .ripple-center {
            position: absolute;
            border-radius: 50%;
            /* Use a much thinner line and lower opacity for the Teal */
            border: 0.5px solid var(--color-ink);
            top: 50%;
            left: 30%;
            transform: translate(-50%, -50%);
            opacity: 0.35;
            /* Reduced from 0.6 */
            pointer-events: none;
        }

        /* Change 10: Secondary ripple rings — subtle terra cotta tint */
        .ripple-secondary {
            position: absolute;
            border-radius: 50%;
            /* Use the Terracotta but at a very faint opacity */
            border: 0.5px solid var(--color-terra);
            top: 20%;
            left: 80%;
            transform: translate(-50%, -50%);
            opacity: 0.32;
            /* Reduced from 0.6 */
            pointer-events: none;
        }

        /* Services Grid */
        .services-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
        }

        .service-card {
            position: relative;
            padding: 2rem;
            border-right: var(--grid-line);
            border-bottom: var(--grid-line);
            min-height: 200px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: background 0.3s, color 0.3s;
        }

        .service-card:nth-child(2n) {
            border-right: none;
        }

        .service-card:nth-child(3),
        .service-card:nth-child(4) {
            border-bottom: none;
        }

        .service-card:hover {
            background: var(--color-ink);
            color: var(--color-bg);
        }

        .service-card:hover h3,
        .service-card:hover p,
        .service-card:hover .label {
            color: var(--color-bg);
        }

        .service-card:hover .arrow-icon {
            transform: translateX(10px);
        }

        .service-card h3 {
            margin-bottom: 0.5rem;
        }

        /* Arrow — Change 3: terra cotta by default */
        .arrow-icon {
            width: 40px;
            height: 1px;
            background: var(--color-terra);
            position: relative;
            display: inline-block;
            transition: transform 0.3s ease, background-color 0.3s ease;
        }

        .arrow-icon::after {
            content: '';
            position: absolute;
            right: 0;
            top: -5px;
            width: 10px;
            height: 10px;
            border-top: 1px solid var(--color-terra);
            border-right: 1px solid var(--color-terra);
            transform: rotate(45deg);
            transition: border-color 0.3s ease;
        }

        /* When card is hovered (inverted), arrows flip to white */
        .service-card:hover .arrow-icon {
            background-color: var(--color-bg);
        }

        .service-card:hover .arrow-icon::after {
            border-top-color: var(--color-bg);
            border-right-color: var(--color-bg);
        }

        /* Stretched link — entire card is clickable */
        .service-card > a {
            position: static;
        }
        .service-card > a::after {
            content: '';
            position: absolute;
            inset: 0;
        }

        /* Button — Change 1: terra cotta border + text, fills on hover */
        .btn {
            display: inline-block;
            margin-top: 2rem;
            padding: 1rem 2rem;
            border: 2px solid var(--color-terra);
            text-decoration: none;
            color: var(--color-terra);
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.9rem;
            letter-spacing: 0.05em;
            transition: all 0.3s;
            border-radius: var(--radius-sm);
        }

        .btn:hover {
            background: var(--color-terra);
            color: var(--color-bg);
        }

        .btn-stacked {
            display: inline-flex;
            flex-direction: column;
            gap: 0.3rem;
        }

        .btn-label {
            display: block;
        }

        .btn-hint {
            display: block;
            font-size: 0.7rem;
            font-family: var(--font-mono);
            font-weight: 400;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            opacity: 0.7;
        }

        /* Footer */
        .footer {
            padding: 4rem 2rem;
            display: grid;
            grid-template-columns: 1fr 1fr;
            border-top: 2px solid #a1665e;
        }

        .footer h2 {
            color: var(--color-ink);
        }

        .footer h2 a {
            position: relative;
            transition: color 0.25s ease;
        }

        .footer h2 a::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -2px;
            width: 100%;
            height: 2px;
            background: var(--color-terra);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.25s ease;
        }

        .footer h2 a:hover {
            color: var(--color-ink-dark);
        }

        .footer h2 a:hover::after {
            transform: scaleX(1);
        }

        /* Override global p max-width inside offer cards */
        .service-card p,
        .service-card .track-name {
            max-width: none;
        }

        /* Byline block */
        .byline {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-top: 1.25rem;
            padding-top: 1rem;
            border-top: 1px solid var(--color-ink-light);
        }

        .service-card:hover .byline {
            border-top-color: rgba(255,255,255,0.3);
        }

        .byline-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            border: 1px solid var(--color-ink);
            flex-shrink: 0;
            overflow: hidden;
        }

        .service-card:hover .byline-avatar {
            border-color: rgba(255,255,255,0.4);
        }

        .byline-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .byline-text {
            display: flex;
            flex-direction: column;
            gap: 0.1rem;
        }

        .byline-name {
            font-size: 1.025rem;
            font-weight: 700;
            color: var(--color-ink-darkest);
            letter-spacing: -0.02em;
        }

        .byline-role {
            font-size: 0.9rem;
            color: var(--color-ink);
            font-family: var(--font-mono);
            text-transform: uppercase;
            letter-spacing: 0.06em;
            line-height: 1.3;
        }

        .service-card:hover .byline-name,
        .service-card:hover .byline-role {
            color: var(--color-bg);
        }

        /* Offer card tracks (card 03 — Get Started with AI) */
        .track-list {
            margin-top: 1rem;
            display: flex;
            flex-direction: row;
            align-items: center;
            flex-wrap: wrap;
            gap: 0;
        }

        .track-item {
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .track-item:not(:last-child)::after {
            content: '\203A';
            color: var(--color-terra);
            margin: 0 0.6rem;
            font-size: 1.1rem;
            line-height: 1;
        }

        .track-num {
            font-family: var(--font-mono);
            font-size: 0.7rem;
            font-weight: 600;
            color: var(--color-terra);
            letter-spacing: 0.06em;
            text-transform: uppercase;
        }

        .track-name {
            color: var(--color-ink-dark);
            font-size: 1rem;
            line-height: 1.4;
        }

        .service-card:hover .track-num,
        .service-card:hover .track-name {
            color: var(--color-bg);
        }

        .service-card:hover .track-item:not(:last-child)::after {
            color: var(--color-bg);
        }

        /* Responsive */
        @media (max-width: 900px) {
            .grid-container {
                grid-template-columns: 40px 1fr;
            }

            .ruler-y {
                width: 40px;
            }

            header {
                grid-template-columns: 1fr;
            }

            .header-cell {
                padding: 1.5rem 1rem;
                border-right: none;
                border-bottom: var(--grid-line);
            }
            .form-section { grid-template-columns: 1fr; }
            .form-left { padding: 3rem 1rem; border-right: none; border-bottom: var(--grid-line); }
            .form-right { padding: 3rem 1rem; }


            .hero-section {
                grid-template-columns: 1fr;
            }

            .hero-text {
                padding: 2rem 1rem;
                border-right: none;
            }

            .services-grid {
                grid-template-columns: 1fr;
            }

            .service-card {
            position: relative;
                padding: 1.5rem 1rem;
                border-right: none;
                border-bottom: var(--grid-line);
            }

            .service-card:last-child {
                border-bottom: none;
            }

            .footer {
                padding: 3rem 1rem;
                grid-template-columns: 1fr;
                gap: 2rem;
            }

            .footer&gt;div:last-child {
                text-align: left;
            }

            p {
                max-width: 100%;
            }

            h1 {
                font-size: 3.5rem;
            }
        }
    
        /* Form Layout */
        .form-section { display: grid; grid-template-columns: 1fr 1fr; flex-grow: 1; }
        .form-left h1 { font-size: clamp(2.8rem, 7vw, 6.3rem); line-height: 1; margin-bottom: 2.5rem; }
        .form-left { padding: 4rem 2rem; border-right: var(--grid-line); }
        .form-right { padding: 4rem 2rem; background-image: radial-gradient(circle at 2px 2px, var(--color-ink-light) 1px, transparent 0); background-size: 40px 40px; }
        .instrument-field { margin-bottom: 3rem; position: relative; }
        .instrument-input { width: 100%; background: transparent; border: none; border-bottom: 2px solid var(--color-ink); color: var(--color-ink-darkest); font-family: var(--font-primary); font-size: 1rem; padding: 0.5rem 0; outline: none; cursor: crosshair; transition: border-color 0.3s ease, box-shadow 0.3s ease; }
        .instrument-input:focus { border-bottom-color: #a1665e; box-shadow: 0 1px 0 0 rgba(161, 102, 94, 0.2); }
        .instrument-input::placeholder { color: var(--color-ink-light); }
        .coordinate-selector { border: 1px solid var(--color-ink); height: 300px; position: relative; margin-top: 1rem; overflow: hidden; background: var(--color-bg); border-radius: var(--radius-sm); }
        .crosshair-v { position: absolute; left: 50%; top: 0; bottom: 0; width: 1px; background: #a1665e; pointer-events: none; }
        .crosshair-h { position: absolute; top: 50%; left: 0; right: 0; height: 1px; background: #a1665e; pointer-events: none; }
        .status-indicator { display: flex; align-items: center; gap: 10px; margin-top: 2rem; }
        .status-light { width: 12px; height: 12px; background: var(--color-terra); border-radius: 50%; animation: blink 1s infinite; }
        @keyframes blink { 0% { opacity: 1; } 50% { opacity: 0.3; } 100% { opacity: 1; } }
        .btn-submit { display: block; width: 100%; padding: 2rem; background: var(--color-ink); color: var(--color-bg); border: none; font-weight: 700; text-transform: uppercase; font-size: 1.2rem; font-family: var(--font-primary); text-align: left; letter-spacing: 0.03em; transition: background 0.3s; margin-top: 2rem; cursor: crosshair; border-radius: var(--radius-sm); }
        .btn-submit:hover { background: var(--color-ink-dark); }
        .brief-textarea { width: 100%; min-height: 150px; background: transparent; border: 1px solid var(--color-ink); padding: 1rem; color: var(--color-ink-darkest); font-family: var(--font-primary); font-size: 1rem; resize: vertical; outline: none; cursor: crosshair; border-radius: var(--radius-sm); transition: border-color 0.3s ease, box-shadow 0.3s ease; }
        .brief-textarea:focus { border-color: #a1665e; box-shadow: 0 0 0 2px rgba(161, 102, 94, 0.1); }
        .brief-textarea::placeholder { color: var(--color-ink-light); }

        /* Project Rows */
        .moire-static { position: absolute; top: 50%; right: -10%; width: 600px; height: 600px; border-radius: 50%; border: 2px solid var(--color-ink); opacity: 0.15; pointer-events: none; }
        .calibration-grid { display: grid; grid-template-columns: repeat(3, 1fr); }
        .project-row { grid-column: 1 / -1; display: grid; grid-template-columns: 80px 2fr 1fr 0.5fr; border-bottom: var(--grid-line); padding: 1.5rem 2rem; align-items: start; transition: background 0.3s, color 0.3s; text-decoration: none; color: inherit; }
        .project-row:hover { background: var(--color-ink); color: var(--color-bg); }
        .project-row:hover .project-id, .project-row:hover .project-title, .project-row:hover .project-meta, .project-row:hover .project-year { color: var(--color-bg); }
        .project-main { display: flex; flex-direction: column; gap: 0.35rem; }
        .project-id { font-family: var(--font-mono); font-weight: 700; color: #a1665e; }
        .project-title { font-weight: 700; font-size: 1.5rem; text-transform: uppercase; color: var(--color-ink-darkest); line-height: 1.1; }
        .project-meta { font-size: 0.72rem; text-transform: uppercase; letter-spacing: 0.05em; color: var(--color-ink-dark); }
        .project-year { font-family: var(--font-mono); text-align: right; color: var(--color-ink); }

        /* Capabilities Hero and Accordions */
        .hero-fullbleed { position: relative; height: 30vh; border-bottom: var(--grid-line); overflow: hidden; }
        .moire-canvas { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }
        .hero-center-text { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center; z-index: 10; pointer-events: none; }
        .hero-center-text h1 { font-size: clamp(2.5rem, 6vw, 5rem); color: var(--color-ink-darkest); mix-blend-mode: multiply; }
        .hero-center-text .label { font-size: 1rem; margin-bottom: 2rem; color: var(--color-ink-dark); }
        .capability-row[data-cap="001"] { --cap-accent: #a1665e; }
        .capability-row[data-cap="002"] { --cap-accent: #3d7878; }
        .capability-row[data-cap="003"] { --cap-accent: #046363; }
        .capability-row[data-cap="004"] { --cap-accent: #7a6050; }
        @keyframes fadeUp { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        .capability-row { display: grid; grid-template-columns: 80px 2fr 1fr 60px; border-bottom: var(--grid-line); align-items: center; padding: 0; transition: background 0.3s, color 0.3s; overflow: hidden; }
        .capability-header { display: grid; grid-template-columns: 80px 2fr 1fr 60px; grid-column: 1 / -1; padding: 2rem; align-items: center; transition: background 0.3s, color 0.3s; cursor: crosshair; color: inherit; }
        .capability-header:hover { background: var(--color-ink); }
        .capability-header:hover .cap-number, .capability-header:hover .cap-title, .capability-header:hover .cap-subtitle, .capability-header:hover .cap-toggle { color: var(--color-bg); }
        .header-peek { grid-column: 1 / -1; max-height: 0; overflow: hidden; opacity: 0; transition: max-height 0.2s ease, opacity 0.2s ease, padding 0.2s ease; padding: 0 2rem; font-family: var(--font-mono); font-size: 0.72rem; letter-spacing: 0.05em; color: var(--color-ink-light); border-left: 3px solid var(--cap-accent, var(--color-terra)); pointer-events: none; }
        .header-peek.show { max-height: 40px; opacity: 1; padding: 0.5rem 2rem; }
        .cap-number { font-family: var(--font-mono); font-weight: 700; font-size: 1rem; color: var(--cap-accent, #a1665e); }
        .cap-title { font-weight: 700; font-size: 1.8rem; text-transform: uppercase; letter-spacing: -0.02em; color: var(--color-ink-darkest); }
        .cap-subtitle { font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.06em; color: var(--color-ink-dark); }
        .cap-toggle { font-size: 1.5rem; text-align: right; color: var(--color-ink); transition: transform 0.3s; }
        .cap-toggle.open { transform: rotate(45deg); }
        .capability-detail { grid-column: 1 / -1; max-height: 0; overflow: hidden; transition: max-height 0.5s ease, padding 0.3s ease; background: var(--color-bg); }
        .capability-detail.open { max-height: 900px; }
        .detail-inner { display: grid; grid-template-columns: 1fr 1fr 1fr; padding: 1.5rem 2rem 2rem 2rem; column-gap: 2rem; row-gap: 1.5rem; }
        .detail-brief { grid-column: 1 / -1; font-size: 1rem; line-height: 1.6; color: var(--color-ink-dark); max-width: none; }
        .capability-detail.open .detail-brief { animation: fadeUp 0.4s ease both; }
        .capability-detail.open .detail-row-link { animation: fadeUp 0.4s 0.1s ease both; }
        .detail-row-link { grid-column: 1 / -1; display: block; }
        .detail-link { display: inline-flex; align-items: baseline; gap: 0.4rem; padding: 0.5rem 0 1.5rem 0; text-decoration: none; }
        .detail-link .link-label { font-size: 1.3rem; font-weight: 700; letter-spacing: -0.02em; color: var(--cap-accent, var(--color-terra)); border-bottom: 2px solid transparent; transition: border-color 0.2s; }
        .detail-link .link-arrow { font-size: 1.3rem; font-weight: 700; color: var(--cap-accent, var(--color-terra)); transition: transform 0.2s ease; }
        .detail-link:hover .link-label { border-color: var(--cap-accent, var(--color-terra)); }
        .detail-link:hover .link-arrow { transform: translate(3px, -3px); }
        .stats-bar { display: grid; grid-template-columns: repeat(4, 1fr); border-bottom: var(--grid-line); }
        .stat-cell { padding: 2rem; border-right: var(--grid-line); text-align: center; }
        .stat-cell:last-child { border-right: none; }
        .stat-number { font-size: 3rem; font-weight: 700; color: var(--color-ink-darkest); letter-spacing: -0.04em; line-height: 1; }
        .stat-label { margin-top: 0.5rem; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.08em; color: var(--color-ink); font-family: var(--font-mono); }

        /* Capability Detail Pages */
        .nav-crumb { font-family: var(--font-mono); font-size: 0.72rem; text-transform: uppercase; letter-spacing: 0.08em; color: var(--color-ink); display: flex; align-items: center; gap: 0.6rem; padding: 0 1.5rem; }
        .nav-crumb .sep { opacity: 0.4; }
        .nav-crumb .cur { color: var(--color-terra); }
        
        .hero-detail { background: var(--color-ink-darkest); padding: 1.4rem 2rem; border-bottom: 3px solid var(--color-terra); position: relative; overflow: hidden; }
        .hero-detail-moire { position: absolute; inset: 0; pointer-events: none; display: block; width: 100%; height: 100%; }
        .hero-detail-content { position: relative; z-index: 1; }
        .hero-detail h1 { font-family: var(--font-primary); font-size: clamp(1.8rem, 3.5vw, 3.2rem); font-weight: 700; letter-spacing: -0.045em; line-height: 0.95; color: #fff; margin-bottom: 0; }
        
        /* ── Essay + Marginalia layout (capability detail pages) ─── */
        .page-body { border-bottom: var(--grid-line); }

        .essay-section {
            display: grid;
            grid-template-columns: 1fr 200px;
            grid-template-rows: auto 1fr;
            border-bottom: var(--grid-line);
        }
        .essay-section:last-child { border-bottom: none; }

        .essay-section-label {
            grid-column: 1 / -1;
            font-family: var(--font-mono);
            font-size: 0.65rem;
            text-transform: uppercase;
            letter-spacing: 0.12em;
            color: var(--color-ink);
            padding: 0.85rem 1.8rem;
            border-bottom: var(--grid-line);
        }

        .essay-main {
            padding: 2rem 1.5rem 2.5rem 1.8rem;
            min-width: 0;
        }

        .essay-main p {
            max-width: none;
        }

        .essay-main > p {
            font-size: 0.95rem;
            line-height: 1.7;
            color: var(--color-ink-dark);
            margin-bottom: 1.3em;
        }
        .essay-main > p:last-child { margin-bottom: 0; }

        /* Offerings as prose paragraphs */
        .essay-offerings { margin-top: 0.2rem; }
        .essay-offering-para {
            font-size: 0.92rem;
            line-height: 1.7;
            color: var(--color-ink-dark);
            margin-bottom: 1em;
        }
        .essay-offering-para:last-child { margin-bottom: 0; }
        .essay-offering-para strong {
            color: var(--color-ink-darkest);
            font-weight: 700;
        }

        /* Process as a numbered prose list */
        .essay-steps {
            list-style: none;
            counter-reset: estep;
            margin-top: 0.2rem;
        }
        .essay-steps li {
            counter-increment: estep;
            padding: 0 0 1.1em 2em;
            position: relative;
            font-size: 0.92rem;
            line-height: 1.7;
            color: var(--color-ink-dark);
        }
        .essay-steps li:last-child { padding-bottom: 0; }
        .essay-steps li::before {
            content: counter(estep, decimal-leading-zero);
            position: absolute;
            left: 0;
            top: 0.15em;
            font-family: var(--font-mono);
            font-size: 0.58rem;
            color: var(--color-ink-light);
            letter-spacing: 0.05em;
        }
        .essay-steps li strong {
            display: block;
            font-size: 0.8rem;
            font-weight: 700;
            color: var(--color-ink-darkest);
            letter-spacing: -0.01em;
            margin-bottom: 0.2em;
        }

        /* Deliverables as a clean lined list (no borders, no icons) */
        .essay-deliverables { margin-top: 0.5rem; }
        .essay-deliverable {
            display: flex;
            gap: 0.9rem;
            align-items: baseline;
            padding: 0.65rem 0;
            border-bottom: 1px solid var(--color-ink-lighter);
            font-size: 0.88rem;
            color: var(--color-ink-dark);
            line-height: 1.5;
        }
        .essay-deliverable:last-child { border-bottom: none; }
        .essay-deliverable.optional { color: var(--color-ink-light); font-style: italic; }
        .d-mark {
            font-family: var(--font-mono);
            font-size: 0.7rem;
            color: var(--color-ink-light);
            min-width: 14px;
            flex-shrink: 0;
        }

        /* Sidenote (right margin column) */
        .sidenote {
            padding: 2rem 1.8rem 2rem 1.5rem;
        }
        .sidenote-heading {
            display: block;
            font-family: var(--font-mono);
            font-size: 0.58rem;
            text-transform: uppercase;
            letter-spacing: 0.12em;
            color: var(--color-ink);
            margin-bottom: 0.8rem;
        }
        .sidenote-item {
            font-size: 0.76rem;
            line-height: 1.5;
            color: var(--color-ink-dark);
            padding: 0.4rem 0;
            border-bottom: 1px solid var(--color-ink-lighter);
            display: flex;
            gap: 0.4rem;
            align-items: baseline;
        }
        .sidenote-item:last-child { border-bottom: none; }
        .sidenote-item--opt { color: var(--color-ink-light); font-style: italic; }
        .sidenote-item-num {
            font-family: var(--font-mono);
            font-size: 0.56rem;
            color: var(--color-ink-light);
            letter-spacing: 0.05em;
            min-width: 18px;
            flex-shrink: 0;
        }
        
        .cap-nav { display: grid; grid-template-columns: 1fr auto 1fr; border-bottom: var(--grid-line); }
        .cap-nav-prev, .cap-nav-center, .cap-nav-next { padding: 1rem 1.8rem; font-family: var(--font-mono); font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.06em; color: var(--color-ink-dark); text-decoration: none; display: flex; align-items: center; gap: 0.6rem; }
        .cap-nav-prev:hover, .cap-nav-next:hover { color: var(--color-terra); background: rgba(218, 234, 234, 0.5); }
        .cap-nav-center { border-left: var(--grid-line); border-right: var(--grid-line); justify-content: center; color: var(--color-ink); }
        .cap-nav-center:hover { color: var(--color-terra); background: rgba(218, 234, 234, 0.5); }
        .cap-nav-next { justify-content: flex-end; }
        
        .cta-block { background: var(--color-ink-darkest); display: grid; grid-template-columns: 1fr auto; align-items: center; padding: 3.5rem 2.5rem; gap: 2.5rem; border-top: 3px solid var(--color-terra); }
        .cta-block h3 { font-family: var(--font-primary); font-size: clamp(1.6rem, 3vw, 2.2rem); font-weight: 700; letter-spacing: -0.04em; line-height: 0.95; color: #fff; }
        .cta-btn { font-family: var(--font-mono); font-size: 0.72rem; text-transform: uppercase; letter-spacing: 0.1em; color: var(--color-terra); border: 2px solid var(--color-terra); padding: 0.9rem 1.8rem; transition: background 0.2s, color 0.2s; white-space: nowrap; background: transparent; }
        .cta-btn:hover { background: var(--color-terra); color: #fff; }

        /* ── Deliverable List ─────────────────────────────────── */
        .deliverable-list { border-top: var(--grid-line); }
        .deliverable-row {
            display: grid;
            grid-template-columns: 72px 1fr auto;
            align-items: start;
            border-bottom: var(--grid-line);
            padding: 2rem 2rem 2rem 0;
            gap: 1.5rem;
            text-decoration: none;
            color: inherit;
            transition: background 0.25s;
        }
        .deliverable-row:hover { background: var(--color-ink); }
        .deliverable-row:hover .deliverable-title,
        .deliverable-row:hover .deliverable-desc,
        .deliverable-row:hover .deliverable-tag,
        .deliverable-row:hover .deliverable-num { color: var(--color-bg); }
        .deliverable-row:hover .deliverable-arrow { background-color: var(--color-bg); transform: translateX(6px); }
        .deliverable-row:hover .deliverable-arrow::after { border-left-color: var(--color-bg); }
        .deliverable-num {
            font-family: var(--font-mono);
            font-size: 0.72rem;
            font-weight: 700;
            color: var(--color-terra);
            letter-spacing: 0.08em;
            padding-top: 0.2rem;
            text-align: right;
            padding-right: 1.5rem;
            border-right: var(--grid-line);
        }
        .deliverable-body { display: flex; flex-direction: column; gap: 0.4rem; }
        .deliverable-tag {
            font-family: var(--font-mono);
            font-size: 0.68rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: var(--color-ink);
        }
        .deliverable-title {
            font-size: 1.2rem;
            font-weight: 700;
            letter-spacing: -0.03em;
            line-height: 1.05;
            color: var(--color-ink-darkest);
        }
        .deliverable-desc {
            font-size: 0.88rem;
            line-height: 1.5;
            color: var(--color-ink-dark);
            max-width: 52ch;
            margin-top: 0.2rem;
        }
        .deliverable-arrow {
            width: 36px;
            height: 1px;
            background: var(--color-terra);
            position: relative;
            display: inline-block;
            margin-top: 0.6rem;
            flex-shrink: 0;
            transition: transform 0.25s ease, background-color 0.25s ease;
        }
        .deliverable-arrow::after {
            content: '';
            position: absolute;
            right: 0; top: -4px;
            border-top: 4px solid transparent;
            border-bottom: 4px solid transparent;
            border-left: 6px solid var(--color-terra);
            transition: border-color 0.25s ease;
        }
        @media (max-width: 768px) {
            .deliverable-row { grid-template-columns: 48px 1fr auto; padding: 1.5rem 1rem 1.5rem 0; gap: 1rem; }
            .deliverable-num { padding-right: 1rem; font-size: 0.65rem; }
            .deliverable-title { font-size: 1rem; }
        }
</style>
        
        <!-- Inject any page-specific JSON-LD schemas from XML -->
        <xsl:if test="Schema">
            <script type="application/ld+json">
                <xsl:copy-of select="Schema/node()"/>
            </script>
        </xsl:if>
      </head>
      <body>
        <!-- Google Tag Manager (noscript) -->
        <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-5TQXWR2M"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
        <!-- End Google Tag Manager (noscript) -->
        <div class="grid-container">
          <div class="ruler-y">
            <span>0</span><span>100</span><span>200</span><span>300</span><span>400</span>
            <span>500</span><span>600</span><span>700</span><span>800</span><span>900</span>
            <span>1000</span><span>1100</span><span>1200</span><span>1300</span><span>1400</span>
          </div>
          <div class="main-content">
            <div class="ruler-x"></div>

            <xsl:apply-templates select="Header" />
            <xsl:apply-templates select="Hero" />
            <xsl:if test="Hero">
                <div class="ruler-x" style="position: relative; z-index: 1;"></div>
            </xsl:if>
            <xsl:apply-templates select="OfferGrid" />
            <xsl:apply-templates select="ContactForm" />
            <xsl:apply-templates select="SprintForm" />
            <xsl:apply-templates select="StaticHero" />
            <xsl:apply-templates select="ProjectList" />
            <xsl:apply-templates select="CapHero" />
            <xsl:apply-templates select="StatsBar" />
            <xsl:if test="CapHero">
                <div class="ruler-x" style="position:relative; z-index:1;"></div>
            </xsl:if>
            <xsl:apply-templates select="CapabilityList" />
            <xsl:apply-templates select="CapabilityHero" />
            <xsl:apply-templates select="PageBody" />
            <xsl:apply-templates select="CapNav" />
            <xsl:apply-templates select="DeliverableList" />
            <xsl:apply-templates select="Article" />
            <xsl:apply-templates select="PostList" />
            <xsl:apply-templates select="CTABlock" />
            
            <xsl:apply-templates select="Footer" />
          </div>
        </div>
        
        <!-- Page specific scripts -->
        <xsl:if test="@id='index'">
          <script src="/scripts/moire.js" defer="defer"></script>
        </xsl:if>
        <!-- Contact scripts -->
        <xsl:if test="@id='contact'">
          <script src="/scripts/contact.js" defer="defer"></script>
        </xsl:if>
      
        <xsl:if test="@id='capabilities'">
          <script src="/scripts/cap-moire.js" defer="defer"></script>
          <script src="/scripts/accordion.js" defer="defer"></script>
        </xsl:if>

      
        <xsl:if test="@id='capability-detail'">
          <script src="/scripts/cap-detail-moire.js" defer="defer"></script>
        </xsl:if>

        <xsl:if test="@id='ai-sprint'">
          <script src="/scripts/sprint.js" defer="defer"></script>
        </xsl:if>

      </body>
    </html>
  </xsl:template>

  <!-- Component Templates -->
  <xsl:template match="Header">
    <header>
      
        <xsl:choose>
          <xsl:when test="Nav/Breadcrumbs">
            <div class="header-cell" style="padding: 0.9rem 1.2rem; justify-content: center;">
              <a href="/" style="text-decoration:none;display:flex;align-items:center;">
                  <img src="/logo.png" alt="Ajared Logo" style="height:32px;width:auto;display:block;"/>
                  <div class="logo-text" style="font-size: 0.72rem; line-height: 1.2; margin-left: 0.6rem;">Research Inc.</div>
              </a>
            </div>
            <div class="header-cell" style="padding: 0.9rem 1.2rem; justify-content: center;">
              <div class="nav-crumb">
                <xsl:choose>
                  <xsl:when test="Nav/Breadcrumbs/@parent-href">
                    <a href="{Nav/Breadcrumbs/@parent-href}" style="color:inherit;text-decoration:none;"><xsl:value-of select="Nav/Breadcrumbs/@parent-label"/></a>
                  </xsl:when>
                  <xsl:otherwise>
                    <a href="/capabilities/" style="color:inherit;text-decoration:none;">Capabilities</a>
                  </xsl:otherwise>
                </xsl:choose>
                <span class="sep">/</span>
                <span class="cur"><xsl:value-of select="Nav/Breadcrumbs/Current"/></span>
              </div>
            </div>
            <div class="header-cell" style="padding: 0.9rem 1.2rem; align-items: center; justify-content: center;">
              <nav style="display: flex; gap: 1.8rem;">
                <a href="/" style="font-size: 0.72rem;">Index</a>
                <a href="/case-studies/" style="font-size: 0.72rem;">Case Studies</a>
                <a href="/capabilities/" style="font-size: 0.72rem;">Capabilities</a>
                <a href="/contact/" style="font-size: 0.72rem;">Contact</a>
                <a href="https://www.ajared.ng" style="font-size: 0.72rem;">Read</a>
              </nav>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <div class="header-cell">
                <span class="label" style="color: var(--color-ink);">Information Architecture</span>
                <a href="/" style="text-decoration: none; display: block;">
                    <img src="/logo.png" alt="Ajared Logo" style="height: 60px; width: auto; display: block; margin-bottom: 0.4rem;"/>
                    <div class="logo-text" style="font-size: 1.6rem; font-weight: 700; letter-spacing: -0.02em; line-height: 1.1;">Research Inc.</div>
                </a>
            </div>
            
            <div class="header-cell">
              <xsl:choose>
                <xsl:when test="ArchiveBox">
                  <span class="label"><xsl:value-of select="ArchiveBox/@label"/></span>
                  <h2><xsl:value-of select="ArchiveBox/Title"/></h2>
                  <div style="margin-top:auto">
                      <span class="label"><xsl:value-of select="ArchiveBox/StatLabel"/></span>
                      <p><xsl:value-of select="ArchiveBox/StatValue"/></p>
                  </div>
                </xsl:when>
                <xsl:when test="Description">
                  <span class="label">Description</span>
                  <p><xsl:value-of select="Description"/></p>
                </xsl:when>
                <xsl:otherwise>
                  <span class="label">Coordinates</span>
                  <p style="font-size: 0.85em;">
                    <xsl:for-each select="CoordCell">
                      <xsl:value-of select="@city"/><br/>
                      <span style="color: var(--color-terra);"><xsl:value-of select="@lat"/>, <xsl:value-of select="@lng"/></span>
                      <xsl:if test="position() != last()"><br/></xsl:if>
                    </xsl:for-each>
                  </p>
                  <div>
                      <span class="label">Status</span>
                      <p style="font-size: 0.85em;"><span style="display:inline-block; width:7px; height:7px; border-radius:50%; background:var(--color-terra); margin-right:7px; vertical-align:middle; position:relative; top:-1px;"></span><span style="color: var(--color-terra);">Open for Collaboration</span></p>
                  </div>
                </xsl:otherwise>
              </xsl:choose>
            </div>
            
            <div class="header-cell">
                <span class="label">Navigation</span>
                <nav>
                    <p><a href="/">Index</a></p>
                    <p>
                        <xsl:choose>
                          <xsl:when test="Nav/@active='case-studies'">
                            <a href="/case-studies/" style="text-decoration:underline; font-weight:600; color: var(--color-terra);">Case Studies</a>
                          </xsl:when>
                          <xsl:otherwise>
                            <a href="/case-studies/">Case Studies</a>
                          </xsl:otherwise>
                        </xsl:choose>
                    </p>
                    <p>
                        <xsl:choose>
                          <xsl:when test="Nav/@active='capabilities'">
                            <a href="/capabilities/" style="text-decoration:underline; font-weight:600; color: var(--color-terra);">Capabilities</a>
                          </xsl:when>
                          <xsl:otherwise>
                            <a href="/capabilities/">Capabilities</a>
                          </xsl:otherwise>
                        </xsl:choose>
                    </p>
                    <p>
                        <xsl:choose>
                          <xsl:when test="Nav/@active='contact'">
                            <a href="/contact/" style="text-decoration:underline; font-weight:600; color: var(--color-terra);">Contact</a>
                          </xsl:when>
                          <xsl:otherwise>
                            <a href="/contact/">Contact</a>
                          </xsl:otherwise>
                        </xsl:choose>
                    </p>
                    <p><a href="https://www.ajared.ng">Read</a></p>
                </nav>
                <xsl:choose>
                  <xsl:when test="Nav/@arrow">
                    <div style="font-size: 2rem; line-height: 1; color: var(--color-terra);"><xsl:value-of select="Nav/@arrow"/></div>
                  </xsl:when>
                  <xsl:otherwise>
                    <div style="font-size: 2rem; line-height: 1; color: var(--color-terra);">↗</div>
                  </xsl:otherwise>
                </xsl:choose>
            </div>
          </xsl:otherwise>
        </xsl:choose>
      </header>
  </xsl:template>

  <xsl:template match="Nav">
    <nav>
        <p><a href="/">
          <xsl:if test="@active='index'">
            <xsl:attribute name="style">text-decoration:underline; font-weight:600; color: var(--color-terra);</xsl:attribute>
          </xsl:if>
          Index</a>
        </p>
        <p><a href="/case-studies/">
          <xsl:if test="@active='case-studies'">
            <xsl:attribute name="style">text-decoration:underline; font-weight:600; color: var(--color-terra);</xsl:attribute>
          </xsl:if>
        Case Studies</a></p>
        <p><a href="/capabilities/">
          <xsl:if test="@active='capabilities'">
            <xsl:attribute name="style">text-decoration:underline; font-weight:600; color: var(--color-terra);</xsl:attribute>
          </xsl:if>
        Capabilities</a></p>
        <p><a href="/contact/">
          <xsl:if test="@active='contact'">
            <xsl:attribute name="style">text-decoration:underline; font-weight:600; color: var(--color-terra);</xsl:attribute>
          </xsl:if>
        Contact</a></p>
        <p><a href="https://www.ajared.ng">Read</a></p>
    </nav>
  </xsl:template>

  <xsl:template match="Hero">
    <section class="hero-section">
        <div class="hero-text">
            <span class="label" style="margin-bottom: 2rem; color: #a1665e;"><xsl:value-of select="@label"/></span>
            <h1><xsl:copy-of select="Headline/node()"/></h1>
            <p style="margin-top: 2rem; max-width: none;">
                <xsl:copy-of select="Sub/node()"/>
            </p>
            <a href="{CTA/@href}" class="btn btn-stacked">
              <span class="btn-label"><xsl:value-of select="CTA"/></span>
              <xsl:if test="CTA/@hint">
                <span class="btn-hint"><xsl:value-of select="CTA/@hint"/></span>
              </xsl:if>
            </a>
        </div>
        <div class="moire-container" id="moire"></div>
    </section>
  </xsl:template>

  <xsl:template match="OfferGrid">
    <div class="services-grid">
      <xsl:apply-templates select="Offer" />
    </div>
  </xsl:template>

  <xsl:template match="Offer">
    <div class="service-card">
        <div>
            <span class="label"><span style="color: #a1665e;"><xsl:value-of select="@number"/></span> — <xsl:value-of select="@tag"/></span>
            <h3><xsl:value-of select="@title"/></h3>
            <p>
                <!-- Because text() only gets direct text nodes, we need to extract HTML or text inside Offer before Tracks -->
                <xsl:copy-of select="Description/node()"/>
            </p>
            <xsl:if test="Tracks">
              <div class="track-list">
                <xsl:for-each select="Tracks/Track">
                  <div class="track-item">
                      <span class="track-num"><xsl:value-of select="@n"/></span>
                      <span class="track-name"><xsl:value-of select="text()"/></span>
                  </div>
                </xsl:for-each>
              </div>
            </xsl:if>
            <xsl:if test="Byline">
              <div class="byline">
                <div class="byline-avatar">
                  <img src="{Byline/@photo}" alt="{Byline/@name}"/>
                </div>
                <div class="byline-text">
                  <span class="byline-name"><xsl:value-of select="Byline/@name"/></span>
                  <span class="byline-role"><xsl:value-of select="Byline/@role"/></span>
                </div>
              </div>
            </xsl:if>
        </div>
        <a href="{@href}">
            <xsl:choose>
                <xsl:when test="position() = 1">
                    <xsl:attribute name="style">text-decoration: none; color: inherit; display: block; margin-top: 1rem;</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="style">text-decoration: none; color: inherit; display: block; margin-top: 2rem;</xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <div class="arrow-icon"></div>
        </a>
    </div>
  </xsl:template>

  <xsl:template match="Footer">
    <div class="footer">
        <div>
            <span class="label" style="color: var(--color-terra);">Inquiries</span>
            <h2><a href="mailto:{@email}">innovation@<span style="color: #a1665e;">aja</span>red.ca</a></h2>
        </div>
        <div style="text-align:right; display:flex; flex-direction:column; justify-content:center; align-items:flex-end; gap:0.5rem;">
            <p>© <xsl:value-of select="@year"/> Ajared Research Inc.</p>
            <span class="label">R<span style="color:#a1665e">e</span>s<span style="color:#a1665e">ea</span>rch,
                <span style="color:#a1665e">e</span>d<span style="color:#a1665e">u</span>c<span style="color:#a1665e">a</span>t<span style="color:#a1665e">e</span>, d<span style="color:#a1665e">e</span>s<span style="color:#a1665e">i</span>gn.</span>
        </div>
    </div>
  </xsl:template>


  <xsl:template match="ContactForm">
    <section class="form-section">
      <div class="form-left">
          <span class="label">Contact</span>
          <h1>New Inquiry</h1>
          <form id="commission-form" action="https://formspree.io/f/mrearkjn" method="POST">
              <input type="hidden" name="_subject" value="New Inquiry — Ajared Research Inc" />
              <input type="hidden" name="_replyto" value="" />
              <div class="instrument-field">
                  <span class="label">01 / Principal Contact</span>
                  <input type="text" name="name" required="required" class="instrument-input" placeholder="Organization or Individual" />
              </div>
              <div class="instrument-field">
                  <span class="label">02 / Email</span>
                  <input type="email" name="email" required="required" class="instrument-input" placeholder="your-email@domain.com" />
              </div>
              <div class="instrument-field" id="deliverable-field" style="display: none;">
                  <span class="label">03 / Specific Deliverable (Optional)</span>
                  <select name="deliverable" id="deliverable-select" class="instrument-input" style="cursor: crosshair;">
                      <option value="">Select a deliverable...</option>
                  </select>
              </div>
              <div class="instrument-field">
                  <span class="label" id="scope-label">03 / Project Scope / Brief</span>
                  <textarea name="message" id="message-textarea" class="brief-textarea" placeholder="Tell us what you're working on and we'll let you know how we can help..."></textarea>
              </div>
              <div id="form-status" style="display:none; margin-top:1rem; font-family:var(--font-mono); font-size:0.85rem; letter-spacing:0.05em; text-transform:uppercase;"></div>
              <button type="submit" class="btn-submit" id="submit-btn">Send Message ↗</button>
          </form>
      </div>
      <div class="form-right">
          <div style="margin-top: 4rem;">
              <span class="label">Response Times</span>
              <p>We typically respond within 48–72 hours.</p>
          </div>
      </div>
    </section>
  </xsl:template>


  <xsl:template match="StaticHero">
    <section class="hero-section">
        <div class="hero-text">
            <span class="label" style="margin-bottom: 2rem; color: var(--color-terra);"><xsl:value-of select="@label"/></span>
            <h1><xsl:copy-of select="Headline/node()"/></h1>
        </div>
        <div class="moire-static" style="transform: scale(1.5);"></div>
        <div class="moire-static" style="transform: scale(1.2); right: 5%;"></div>
    </section>
  </xsl:template>

  <xsl:template match="ProjectList">
    <div class="calibration-grid">
      <xsl:apply-templates select="Project" />
    </div>
  </xsl:template>

  <xsl:template match="Project">
    <a href="{@href}" class="project-row">
        <span class="project-id"><xsl:value-of select="@id"/></span>
        <div class="project-main">
          <span class="project-meta"><xsl:value-of select="Meta"/></span>
          <span class="project-title"><xsl:value-of select="Title"/></span>
        </div>
        <span class="project-year"><xsl:value-of select="Year"/></span>
        <span style="text-align: right; color: var(--color-terra);">↗</span>
    </a>
  </xsl:template>


  <xsl:template match="CapHero">
    <section class="hero-fullbleed">
        <canvas class="moire-canvas" id="moireCanvas"></canvas>
        <div class="hero-center-text">
            <span class="label"><xsl:value-of select="@label"/></span>
            <h1><xsl:copy-of select="Headline/node()"/></h1>
        </div>
    </section>
  </xsl:template>

  <xsl:template match="StatsBar">
    <div class="stats-bar">
      <xsl:for-each select="Stat">
        <div class="stat-cell">
            <div class="stat-number"><xsl:value-of select="@val"/></div>
            <div class="stat-label"><xsl:value-of select="@label"/></div>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="CapabilityList">
    <div id="capabilities">
      <xsl:apply-templates select="Capability" />
    </div>
  </xsl:template>

  <xsl:template match="Capability">
    <xsl:variable name="idx"><xsl:value-of select="position() - 1"/></xsl:variable>

    <div class="capability-row" data-cap="{@number}">
        <div class="capability-header" onclick="toggleCap({$idx})" id="header-{$idx}">
            <span class="cap-number"><xsl:value-of select="@number"/></span>
            <span class="cap-title"><xsl:value-of select="@title"/></span>
            <span class="cap-subtitle"><xsl:value-of select="@subtitle"/></span>
            <span class="cap-toggle" id="toggle-{$idx}">+</span>
        </div>
        <div class="header-peek" id="peek-{$idx}"><xsl:value-of select="Peek"/></div>
        <div class="capability-detail" id="detail-{$idx}">
            <div class="detail-inner">
                <p class="detail-brief"><xsl:copy-of select="Description/node()"/></p>
                <div class="detail-block detail-row-link">
                    <a href="{@href}" class="detail-link">
                        <span class="link-label">Learn more</span>
                        <span class="link-arrow">↗</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
  </xsl:template>


  <xsl:template match="DeliverableList">
    <div class="deliverable-list">
      <xsl:apply-templates select="Deliverable" />
    </div>
  </xsl:template>

  <xsl:template match="Deliverable">
    <a href="{@href}" class="deliverable-row" target="_blank">
      <span class="deliverable-num"><xsl:value-of select="@number"/></span>
      <div class="deliverable-body">
        <span class="deliverable-tag"><xsl:value-of select="@tag"/></span>
        <span class="deliverable-title"><xsl:value-of select="@title"/></span>
        <p class="deliverable-desc"><xsl:value-of select="Description"/></p>
      </div>
      <div class="deliverable-arrow"></div>
    </a>
  </xsl:template>

  <xsl:template match="CapabilityHero">
    <div class="hero-detail">
      <canvas class="hero-detail-moire" id="heroMoire"></canvas>
      <div class="hero-detail-content">
        <h1><xsl:value-of select="Title"/></h1>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="PageBody">
    <div class="page-body">
      <xsl:apply-templates select="Section" />
    </div>
  </xsl:template>

  <xsl:template match="Section">
    <div class="essay-section">
      <div class="essay-section-label"><xsl:value-of select="@title"/></div>
      <!-- Main content column -->
      <div class="essay-main">
        <xsl:copy-of select="Intro/node()"/>
        <xsl:apply-templates select="Offerings" />
        <xsl:apply-templates select="Process" />
        <!-- Deliverables render in main only when no Intro exists; otherwise they migrate to sidenote -->
        <xsl:if test="not(Intro)">
          <xsl:apply-templates select="Deliverables" />
        </xsl:if>
      </div>
      <!-- Margin / sidenote column -->
      <div class="sidenote">
        <xsl:choose>
          <xsl:when test="Offerings">
            <span class="sidenote-heading">Disciplines</span>
            <xsl:for-each select="Offerings/Offering">
              <div class="sidenote-item"><xsl:value-of select="Title"/></div>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="Process">
            <span class="sidenote-heading">Steps</span>
            <xsl:for-each select="Process/Step">
              <div class="sidenote-item">
                <span class="sidenote-item-num"><xsl:value-of select="@num"/></span>
                <xsl:value-of select="Title"/>
              </div>
            </xsl:for-each>
          </xsl:when>
          <!-- Deliverables section: when Intro is present, the list lives here -->
          <!-- Uses @label attribute for short sidenote display; falls back to full text -->
          <xsl:when test="Deliverables and Intro">
            <span class="sidenote-heading">Included</span>
            <xsl:for-each select="Deliverables/Row">
              <xsl:choose>
                <xsl:when test="@checked='false'">
                  <div class="sidenote-item sidenote-item--opt">
                    <xsl:choose>
                      <xsl:when test="@label"><xsl:value-of select="@label"/></xsl:when>
                      <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                    </xsl:choose>
                  </div>
                </xsl:when>
                <xsl:otherwise>
                  <div class="sidenote-item">
                    <xsl:choose>
                      <xsl:when test="@label"><xsl:value-of select="@label"/></xsl:when>
                      <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                    </xsl:choose>
                  </div>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </xsl:when>
          <!-- Deliverables section: fallback when no Intro, sidenote shows count label -->
          <xsl:when test="Deliverables">
            <span class="sidenote-heading">Included</span>
            <xsl:for-each select="Deliverables/Row[@checked='true']">
              <div class="sidenote-item"><xsl:value-of select="."/></div>
            </xsl:for-each>
          </xsl:when>
        </xsl:choose>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="Offerings">
    <div class="essay-offerings">
      <xsl:for-each select="Offering">
        <p class="essay-offering-para">
          <strong><xsl:value-of select="Title"/></strong>&#160;&#8212;&#160;<xsl:copy-of select="Description/node()"/>
        </p>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="Process">
    <ol class="essay-steps">
      <xsl:for-each select="Step">
        <li>
          <strong><xsl:value-of select="Title"/></strong>
          <xsl:copy-of select="Description/node()"/>
        </li>
      </xsl:for-each>
    </ol>
  </xsl:template>

  <xsl:template match="Deliverables">
    <div class="essay-deliverables">
      <xsl:for-each select="Row">
        <div>
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="@checked='false'">essay-deliverable optional</xsl:when>
              <xsl:otherwise>essay-deliverable</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <span class="d-mark">
            <xsl:choose>
              <xsl:when test="@checked='false'">+</xsl:when>
              <xsl:otherwise>&#8212;</xsl:otherwise>
            </xsl:choose>
          </span>
          <xsl:value-of select="."/>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="CapNav">
    <div class="cap-nav">
      <xsl:choose>
        <xsl:when test="Prev">
          <a href="{Prev/@href}" class="cap-nav-prev">&#8592; <xsl:value-of select="Prev"/></a>
        </xsl:when>
        <xsl:otherwise>
          <div class="cap-nav-prev"></div>
        </xsl:otherwise>
      </xsl:choose>
      
      <a href="/capabilities/" class="cap-nav-center">All Capabilities</a>
      
      <xsl:choose>
        <xsl:when test="Next">
          <a href="{Next/@href}" class="cap-nav-next"><xsl:value-of select="Next"/> &#8594;</a>
        </xsl:when>
        <xsl:otherwise>
           <div class="cap-nav-next"></div>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <xsl:template match="CTABlock">
    <div class="cta-block">
      <div>
        <h3><xsl:copy-of select="Title/node()"/></h3>
        <xsl:if test="Hint">
          <p style="font-family: var(--font-mono); font-size: 0.72rem; text-transform: uppercase; letter-spacing: 0.08em; color: var(--color-ink-light); margin-top: 0.75rem; line-height: 1.5; max-width: none;"><xsl:value-of select="Hint"/></p>
        </xsl:if>
      </div>
      <a href="{Button/@href}" style="text-decoration:none;">
        <div class="cta-btn"><xsl:value-of select="Button"/></div>
      </a>
    </div>
  </xsl:template>

  <!-- ═══════════════════════════════════════════════════════════ -->
  <!-- SprintForm — 1 Month AI Development Sprint Intake Assessment -->
  <!-- ═══════════════════════════════════════════════════════════ -->
  <xsl:template match="SprintForm">
    <style>
      /* ── Sprint Assessment ── */
      .sprint-hero {
        padding: 3rem 2rem;
        border-bottom: var(--grid-line);
        max-width: 760px;
      }
      .sprint-hero h1 {
        font-size: clamp(2.8rem, 7vw, 5.5rem);
        margin: 1rem 0 1.5rem;
        line-height: 0.92;
      }
      .sprint-hero p { max-width: 44ch; color: var(--color-ink-dark); }

      /* Progress row */
      .sprint-progress-row {
        display: flex;
        align-items: center;
        gap: 1.5rem;
        padding: 1rem 2rem;
        border-bottom: var(--grid-line);
        position: sticky;
        top: 40px;
        background: var(--color-bg);
        z-index: 90;
      }
      .sprint-progress-track {
        flex: 1;
        height: 2px;
        background: var(--color-ink-lighter);
        position: relative;
      }
      .sprint-progress-fill {
        height: 100%;
        background: var(--color-ink);
        transition: width 0.4s ease;
        width: 0%;
      }

      /* Question blocks */
      .sprint-q-block {
        border-bottom: var(--grid-line);
        padding: 2rem;
      }
      .sprint-q-header {
        display: flex;
        align-items: baseline;
        gap: 1rem;
        margin-bottom: 1.2rem;
        flex-wrap: wrap;
      }
      .sprint-q-num {
        font-family: var(--font-mono);
        font-size: 0.75rem;
        color: var(--color-ink);
        letter-spacing: 0.08em;
        flex-shrink: 0;
      }
      .sprint-q-label {
        font-size: 1.05rem;
        font-weight: 700;
        letter-spacing: -0.02em;
        color: var(--color-ink-darkest);
        flex: 1;
        line-height: 1.2;
      }
      .sprint-q-hint {
        font-family: var(--font-mono);
        font-size: 0.7rem;
        text-transform: uppercase;
        letter-spacing: 0.08em;
        color: var(--color-ink-light);
      }

      /* Option grid */
      .sprint-options {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        border-top: 1px solid var(--color-ink-lighter);
        border-left: 1px solid var(--color-ink-lighter);
      }
      .sprint-opt {
        padding: 0.9rem 1rem;
        border-right: 1px solid var(--color-ink-lighter);
        border-bottom: 1px solid var(--color-ink-lighter);
        background: var(--color-bg);
        font-family: var(--font-primary);
        font-size: 0.95rem;
        color: var(--color-ink-dark);
        text-align: left;
        cursor: crosshair;
        transition: background 0.15s, color 0.15s, border-color 0.15s;
        display: flex;
        align-items: flex-start;
        gap: 0.6rem;
        line-height: 1.35;
        border-radius: 0;
        outline: none;
      }
      .sprint-opt:hover {
        background: var(--color-ink-lighter);
        color: var(--color-ink-darkest);
      }
      .sprint-opt.selected {
        background: var(--color-ink);
        color: var(--color-bg);
        border-color: var(--color-ink);
      }
      .sprint-opt.disabled { opacity: 0.35; cursor: not-allowed; }
      .sprint-opt.disabled:hover { background: var(--color-bg); color: var(--color-ink-dark); }
      .sprint-opt-mark {
        width: 14px;
        height: 14px;
        border: 1.5px solid currentColor;
        border-radius: 2px;
        flex-shrink: 0;
        margin-top: 2px;
        display: flex;
        align-items: center;
        justify-content: center;
      }
      .sprint-opt-mark.radio { border-radius: 50%; }
      .sprint-opt.selected .sprint-opt-mark::after {
        content: '';
        width: 6px;
        height: 6px;
        border-radius: 1px;
        background: var(--color-bg);
        display: block;
      }
      .sprint-opt.selected .sprint-opt-mark.radio::after { border-radius: 50%; }

      /* Submit row */
      .sprint-submit-row {
        padding: 2rem;
        border-bottom: var(--grid-line);
        display: flex;
        align-items: center;
        gap: 2rem;
        flex-wrap: wrap;
      }
      .sprint-btn {
        font-family: var(--font-primary);
        font-size: 1rem;
        font-weight: 700;
        letter-spacing: -0.01em;
        padding: 0.85rem 2rem;
        background: var(--color-ink-darkest);
        color: var(--color-bg);
        border: none;
        cursor: crosshair;
        transition: background 0.2s;
        border-radius: 0;
      }
      .sprint-btn:hover { background: var(--color-ink); }
      .sprint-btn:disabled { background: var(--color-ink-lighter); cursor: not-allowed; }
      .sprint-submit-hint {
        font-family: var(--font-mono);
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.08em;
        color: var(--color-ink-light);
      }

      /* Lead capture */
      .sprint-lead-inner {
        display: grid;
        grid-template-columns: 1fr 1fr;
        border-bottom: var(--grid-line);
      }
      .sprint-lead-left {
        padding: 3rem 2rem;
        border-right: var(--grid-line);
      }
      .sprint-lead-left h2 {
        font-size: clamp(2rem, 5vw, 4rem);
        margin: 1rem 0 1.5rem;
        line-height: 0.92;
      }
      .sprint-lead-right {
        padding: 3rem 2rem;
        display: flex;
        flex-direction: column;
        justify-content: center;
      }

      /* Results */
      .sprint-results-inner { border-bottom: var(--grid-line); }
      .sprint-level-row {
        padding: 3rem 2rem;
        border-bottom: var(--grid-line);
        display: flex;
        align-items: flex-end;
        gap: 2rem;
        flex-wrap: wrap;
      }
      .sprint-level-badge {
        font-family: var(--font-mono);
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.12em;
        padding: 0.35rem 0.8rem;
        border: 1.5px solid currentColor;
        border-radius: 0;
      }
      .sprint-level-score {
        font-size: clamp(3rem, 8vw, 6rem);
        font-weight: 700;
        letter-spacing: -0.04em;
        line-height: 1;
        color: var(--color-ink-darkest);
      }
      .sprint-level-desc {
        font-size: 1rem;
        color: var(--color-ink-dark);
        max-width: 40ch;
        line-height: 1.5;
        margin-top: 0.75rem;
      }
      .sprint-profile-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        border-top: var(--grid-line);
      }
      .sprint-profile-cell {
        padding: 2rem;
        border-right: var(--grid-line);
        border-bottom: var(--grid-line);
      }
      .sprint-profile-cell:nth-child(2n) { border-right: none; }
      .sprint-dim-val {
        font-size: clamp(2rem, 5vw, 3.5rem);
        font-weight: 700;
        letter-spacing: -0.04em;
        line-height: 1;
        color: var(--color-ink-darkest);
        margin: 0.5rem 0 0.25rem;
      }
      .sprint-dim-track {
        width: 100%;
        height: 2px;
        background: var(--color-ink-lighter);
        margin-top: 0.5rem;
      }
      .sprint-dim-fill {
        height: 100%;
        background: var(--color-ink);
        transition: width 1s ease-out;
      }
      .sprint-steps {
        padding: 2rem;
        border-bottom: var(--grid-line);
      }
      .sprint-step-item {
        display: grid;
        grid-template-columns: 28px 1fr;
        gap: 1rem;
        padding: 1rem 0;
        border-bottom: 1px solid var(--color-ink-lighter);
      }
      .sprint-step-item:last-child { border-bottom: none; }
      .sprint-step-num {
        font-family: var(--font-mono);
        font-size: 0.75rem;
        color: var(--color-terra);
        padding-top: 0.15rem;
      }
      .sprint-step-text { font-size: 0.95rem; color: var(--color-ink-dark); line-height: 1.5; }
      .sprint-cta-row {
        display: grid;
        grid-template-columns: 1fr auto;
        align-items: center;
        gap: 2rem;
        padding: 2rem;
        border-bottom: var(--grid-line);
        flex-wrap: wrap;
      }
      .sprint-retake {
        padding: 1.5rem 2rem;
        font-family: var(--font-mono);
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.08em;
        color: var(--color-ink-light);
        background: none;
        border: none;
        cursor: crosshair;
      }
      .sprint-retake:hover { color: var(--color-ink); }

      @media (max-width: 640px) {
        .sprint-options { grid-template-columns: 1fr; }
        .sprint-lead-inner { grid-template-columns: 1fr; }
        .sprint-lead-left { border-right: none; border-bottom: var(--grid-line); }
        .sprint-profile-grid { grid-template-columns: 1fr; }
        .sprint-profile-cell { border-right: none; }
        .sprint-cta-row { grid-template-columns: 1fr; }
        .sprint-progress-row { top: 0; }
      }
    </style>

    <!-- ── Quiz Stage ── -->
    <div id="sprint-quiz">
      <div class="sprint-hero">
        <span class="label">Sprint Application / Intake Assessment</span>
        <h1>1 Month<br/>AI Development<br/>Sprint</h1>
        <p>Tell us where you're at. We'll show you how ready you are and what to prepare before the sprint begins. Takes 3 minutes.</p>
      </div>

      <div class="sprint-progress-row">
        <span class="label" id="sprint-progress-label">00 / 08 answered</span>
        <div class="sprint-progress-track">
          <div class="sprint-progress-fill" id="sprint-progress-fill"></div>
        </div>
      </div>

      <div id="sprint-questions"></div>

      <div class="sprint-submit-row">
        <button class="sprint-btn" id="sprint-submit" disabled="disabled">See Readiness Report ↗</button>
        <span class="sprint-submit-hint" id="sprint-submit-hint">Answer all questions to continue</span>
      </div>
    </div>

    <!-- ── Lead Capture Stage ── -->
    <div id="sprint-lead" style="display:none">
      <div class="sprint-lead-inner">
        <div class="sprint-lead-left">
          <span class="label">Almost there</span>
          <h2>Get Your<br/>Report</h2>
          <p>Enter your details to unlock your sprint readiness profile and personalized preparation plan.</p>
        </div>
        <div class="sprint-lead-right">
          <form id="sprint-lead-form" action="https://formspree.io/f/mwvrkwll" method="POST">
            <input type="hidden" name="_subject" value="1 Month AI Development Sprint — Assessment"/>
            <input type="hidden" name="assessment_level" id="sprint-hidden-level"/>
            <input type="hidden" name="assessment_score" id="sprint-hidden-score"/>
            <input type="hidden" name="assessment_answers" id="sprint-hidden-answers"/>
            <div class="instrument-field">
              <span class="label">Name</span>
              <input type="text" name="name" id="sprint-lead-name" class="instrument-input" placeholder="Your name"/>
            </div>
            <div class="instrument-field" style="margin-top: 1rem;">
              <span class="label">Email</span>
              <input type="email" name="email" id="sprint-lead-email" class="instrument-input" placeholder="you@example.com" required="required"/>
            </div>
            <div id="sprint-lead-error" style="display:none; color:var(--color-terra); font-family:var(--font-mono); font-size:0.8rem; text-transform:uppercase; letter-spacing:0.06em; margin-top:1rem;"></div>
            <button type="submit" class="sprint-btn" style="margin-top:1.5rem; width:100%;">Show My Report ↗</button>
          </form>
        </div>
      </div>
    </div>

    <!-- ── Results Stage ── -->
    <div id="sprint-results" style="display:none">
      <div class="sprint-results-inner">
        <div class="sprint-level-row">
          <div>
            <div class="sprint-level-badge" id="sprint-level-badge"></div>
            <div class="sprint-level-score" id="sprint-level-score"></div>
            <div class="label" style="margin-top:0.5rem; color:var(--color-ink-light);">Sprint Readiness Score</div>
            <p class="sprint-level-desc" id="sprint-level-desc"></p>
          </div>
        </div>

        <div class="sprint-profile-grid" id="sprint-dim-grid"></div>

        <div class="sprint-steps">
          <span class="label" style="margin-bottom:1.5rem; display:block;">Before The Sprint Starts</span>
          <div id="sprint-steps-list"></div>
        </div>

        <div class="sprint-cta-row">
          <div>
            <span class="label">Ready to apply?</span>
            <p style="margin-top:0.5rem;">Book a 20-minute discovery call to confirm your spot and align on sprint goals.</p>
          </div>
          <a href="https://cal.com/ajared" target="_blank" rel="noopener noreferrer" class="sprint-btn" style="white-space:nowrap; display:inline-block;">Book a Discovery Call ↗</a>
        </div>

        <div style="text-align:center;">
          <button class="sprint-retake" id="sprint-retake">↻ Retake Assessment</button>
        </div>
      </div>
    </div>
  </xsl:template>


  <!-- ═══════════════════════════════════════════════
       Talk page — standalone root template
       Source: talk/index.xml
       ═══════════════════════════════════════════════ -->
  <xsl:template match="/TalkPage">
    <html lang="en">
      <head>
        <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],j=d.createElement(s),dl=l!='dataLayer'?'&amp;l='+l:'';j.async=true;j.src='https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);})(window,document,'script','dataLayer','GTM-5TQXWR2M');</script>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Talk to a Human about AI — Ajared Research Inc.</title>
        <meta name="description" content="A 30-minute conversation with an AI practitioner who has shipped products. $500 USD. Walk away knowing exactly where AI fits your work."/>
        <meta property="og:type" content="website"/>
        <meta property="og:url" content="https://ajared.ca/talk/"/>
        <meta property="og:title" content="Talk to a Human about AI — Ajared Research Inc."/>
        <meta property="og:description" content="30 minutes. $500 USD. A direct conversation with an AI practitioner — not a pitch."/>
        <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png"/>
        <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png"/>
        <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png"/>
        <style>
        @font-face { font-family:'iA Writer Quattro S'; src:url('/fonts/iAWriterQuattroS-Regular.woff2') format('woff2'),url('/fonts/iAWriterQuattroS-Regular.woff') format('woff'); font-weight:400; font-style:normal; }
        @font-face { font-family:'iA Writer Quattro S'; src:url('/fonts/iAWriterQuattroS-Bold.woff2') format('woff2'),url('/fonts/iAWriterQuattroS-Bold.woff') format('woff'); font-weight:700; font-style:normal; }
        @font-face { font-family:'iA Writer Quattro S'; src:url('/fonts/iAWriterQuattroS-Italic.woff2') format('woff2'),url('/fonts/iAWriterQuattroS-Italic.woff') format('woff'); font-weight:400; font-style:italic; }
        :root {
          --ink:       #141414;
          --ink-mid:   #4b5563;
          --ink-light: #9ca3af;
          --terra:     #a1665e;
          --bg:        #f9f8f6;
          --white:     #ffffff;
          --rule:      #e5e7eb;
          --font:      'iA Writer Quattro S','Helvetica Neue',Helvetica,Arial,sans-serif;
          --mono:      'iA Writer Quattro S','Courier New',monospace;
        }
        *{box-sizing:border-box;margin:0;padding:0;}
        body{font-family:var(--font);background:var(--bg);color:var(--ink);font-size:16px;line-height:1.6;cursor:crosshair;}
        a{cursor:crosshair;}
        .wrap{max-width:680px;margin:0 auto;padding:0 2rem;}
        /* Nav */
        .site-header{display:flex;justify-content:space-between;align-items:center;padding:0.75rem 2rem;border-bottom:1px solid var(--rule);max-width:100%;}
        .site-header a{text-decoration:none;color:var(--ink);display:flex;align-items:center;gap:0.5rem;}
        .site-header img{height:32px;width:auto;}
        .site-header .wordmark{font-size:0.82rem;font-weight:700;letter-spacing:-0.02em;color:var(--ink);}
        .header-nav a{font-size:0.72rem;font-family:var(--mono);color:var(--ink-light);text-decoration:none;text-transform:uppercase;letter-spacing:0.08em;}
        .header-nav a:hover{color:var(--terra);}
        /* Hero */
        .hero{padding:2rem 0 1.25rem;}
        .hero-label{font-size:0.7rem;font-family:var(--mono);text-transform:uppercase;letter-spacing:0.12em;color:var(--terra);margin-bottom:0.55rem;}
        .hero h1{font-size:clamp(1.35rem,5.5vw,2.8rem);font-weight:700;line-height:1.05;letter-spacing:-0.04em;margin-bottom:0.9rem;}
        .hero-meta{display:flex;gap:2rem;margin-bottom:0.9rem;}
        .meta-item{display:flex;flex-direction:column;gap:0.1rem;}
        .meta-label{font-size:0.62rem;font-family:var(--mono);text-transform:uppercase;letter-spacing:0.1em;color:var(--ink-light);}
        .meta-value{font-size:0.88rem;font-weight:700;color:var(--ink);}
        .hero-lede{font-size:0.88rem;color:var(--ink-mid);line-height:1.6;max-width:520px;}
        .hero-for{font-size:0.74rem;color:var(--ink-light);margin-top:0.45rem;}
        /* Timeline */
        .hero-timeline{margin-top:1rem;width:100%;position:relative;}
        .tl-icons{position:relative;height:20px;}
        .tl-icon{position:absolute;transform:translateX(-50%);}
        .tl-icon.first{transform:translateX(0);}
        .tl-icon.last{transform:translateX(-100%);}
        .tl-track{height:1px;background:var(--terra);margin:0.22rem 0;position:relative;}
        .tl-track::before,.tl-track::after{content:'';position:absolute;top:50%;transform:translateY(-50%);width:5px;height:5px;border-radius:50%;background:var(--terra);}
        .tl-track::before{left:0;}
        .tl-track::after{right:0;}
        .tl-tick{position:absolute;top:50%;transform:translate(-50%,-50%);width:1.5px;height:8px;background:var(--terra);opacity:0.6;}
        .tl-labels{position:relative;height:2rem;}
        .tl-node{position:absolute;transform:translateX(-50%);display:flex;flex-direction:column;align-items:center;}
        .tl-node.first{transform:translateX(0);align-items:flex-start;}
        .tl-node.last{transform:translateX(-100%);align-items:flex-end;}
        .tl-time{font-size:0.55rem;font-family:var(--mono);color:var(--terra);text-transform:uppercase;letter-spacing:0.06em;white-space:nowrap;}
        .tl-label{font-size:0.7rem;font-weight:700;color:var(--ink);white-space:nowrap;margin-top:0.08rem;}
        /* Section */
        .section{padding:1rem 0;border-top:1px solid var(--rule);border-bottom:1px solid var(--rule);}
        .section-label{font-size:0.62rem;font-family:var(--mono);text-transform:uppercase;letter-spacing:0.12em;color:var(--ink-light);margin-bottom:0.55rem;}
        /* Deliverables */
        .deliverables{display:grid;grid-template-columns:1fr 1fr;gap:0;}
        .deliverable{display:grid;grid-template-columns:1.75rem 1fr;gap:0 0.6rem;padding:0.4rem 0;}
        .deliverable.full{grid-column:1/-1;}
        .deliverable:nth-child(odd):not(.full){padding-right:1rem;}
        .d-num{font-size:0.6rem;font-family:var(--mono);color:var(--terra);font-weight:700;padding-top:0.1rem;}
        .d-tag{font-size:0.62rem;font-family:var(--mono);text-transform:uppercase;letter-spacing:0.1em;color:var(--terra);margin-bottom:0.08rem;}
        .d-title{font-size:0.76rem;font-weight:700;color:var(--ink);letter-spacing:-0.01em;line-height:1.25;}
        /* Bottom row */
        .bottom-row{display:grid;grid-template-columns:1fr auto;gap:2rem;align-items:center;padding:1.1rem 0 1.5rem;}
        .byline{display:flex;gap:0.75rem;align-items:flex-start;}
        .byline-photo{width:36px;height:36px;border-radius:50%;object-fit:cover;flex-shrink:0;}
        .byline-name{font-size:0.82rem;font-weight:700;color:var(--ink);letter-spacing:-0.02em;}
        .byline-role{font-size:0.6rem;font-family:var(--mono);text-transform:uppercase;letter-spacing:0.07em;color:var(--terra);margin-top:0.08rem;margin-bottom:0.28rem;}
        .byline-bio{font-size:0.74rem;color:var(--ink-mid);line-height:1.5;}
        .cta-btn{display:inline-flex;flex-direction:column;gap:0.2rem;border:2px solid var(--terra);color:var(--terra);padding:0.85rem 1.5rem;text-decoration:none;transition:all 0.2s;white-space:nowrap;flex-shrink:0;}
        .cta-btn:hover{background:var(--terra);color:var(--white);}
        .cta-label{font-size:0.78rem;font-weight:700;text-transform:uppercase;letter-spacing:0.06em;}
        .cta-hint{font-size:0.6rem;font-family:var(--mono);text-transform:uppercase;letter-spacing:0.07em;opacity:0.7;}
        @media(max-width:600px){
          .bottom-row{grid-template-columns:1fr;gap:1rem;}
          .cta-btn{width:100%;text-align:center;align-items:center;}
        }
        </style>
      </head>
      <body>
        <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-5TQXWR2M" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
        <header class="site-header">
          <a href="/"><img src="/logo.png" alt="Ajared Research Inc"/><span class="wordmark">Research Inc.</span></a>
          <nav class="header-nav"><a href="/">&#8592; ajared.ca</a></nav>
        </header>
        <div class="wrap">
          <!-- Hero -->
          <section class="hero">
            <div class="hero-label"><xsl:value-of select="Hero/@label"/></div>
            <h1><xsl:value-of select="Hero/Headline"/></h1>
            <div class="hero-meta">
              <div class="meta-item"><span class="meta-label">Duration</span><span class="meta-value"><xsl:value-of select="Hero/Meta/@duration"/></span></div>
              <div class="meta-item"><span class="meta-label">Price</span><span class="meta-value"><xsl:value-of select="Hero/Meta/@price"/></span></div>
              <div class="meta-item"><span class="meta-label">Format</span><span class="meta-value"><xsl:value-of select="Hero/Meta/@format"/></span></div>
            </div>
            <p class="hero-lede"><xsl:value-of select="Hero/Lede"/></p>
            <p class="hero-for"><xsl:value-of select="Hero/ForWho"/></p>
            <!-- Timeline -->
            <div class="hero-timeline">
              <div class="tl-icons">
                <xsl:for-each select="Hero/Timeline/Phase">
                  <xsl:variable name="pos" select="@pct"/>
                  <xsl:variable name="cls">
                    <xsl:choose>
                      <xsl:when test="@pct='0'">tl-icon first</xsl:when>
                      <xsl:when test="@pct='100'">tl-icon last</xsl:when>
                      <xsl:otherwise>tl-icon</xsl:otherwise>
                    </xsl:choose>
                  </xsl:variable>
                  <div class="{$cls}" style="left:{$pos}%">
                    <xsl:choose>
                      <xsl:when test="@hourglass='full'">
                        <svg width="14" height="20" viewBox="0 0 14 20" fill="none"><path d="M1 1h12L8.5 9H5.5L1 1z" stroke="#a1665e" stroke-width="1.1" stroke-linejoin="round"/><path d="M1 19h12L8.5 11H5.5L1 19z" stroke="#a1665e" stroke-width="1.1" stroke-linejoin="round"/><path d="M2.5 2.5h9L8.5 9H5.5z" fill="#a1665e" opacity="0.35"/></svg>
                      </xsl:when>
                      <xsl:when test="@hourglass='half'">
                        <svg width="14" height="20" viewBox="0 0 14 20" fill="none"><path d="M1 1h12L8.5 9H5.5L1 1z" stroke="#a1665e" stroke-width="1.1" stroke-linejoin="round"/><path d="M1 19h12L8.5 11H5.5L1 19z" stroke="#a1665e" stroke-width="1.1" stroke-linejoin="round"/><path d="M4.5 6h5L8.5 9H5.5z" fill="#a1665e" opacity="0.35"/><path d="M5.5 11h3L11 17H3z" fill="#a1665e" opacity="0.35"/></svg>
                      </xsl:when>
                      <xsl:otherwise>
                        <svg width="14" height="20" viewBox="0 0 14 20" fill="none"><path d="M1 1h12L8.5 9H5.5L1 1z" stroke="#a1665e" stroke-width="1.1" stroke-linejoin="round"/><path d="M1 19h12L8.5 11H5.5L1 19z" stroke="#a1665e" stroke-width="1.1" stroke-linejoin="round"/><path d="M5.5 11h3l3.5 6.5H2z" fill="#a1665e" opacity="0.35"/></svg>
                      </xsl:otherwise>
                    </xsl:choose>
                  </div>
                </xsl:for-each>
              </div>
              <div class="tl-track">
                <xsl:for-each select="Hero/Timeline/Tick">
                  <div class="tl-tick" style="left:{@pct}%"></div>
                </xsl:for-each>
              </div>
              <div class="tl-labels">
                <xsl:for-each select="Hero/Timeline/Phase">
                  <xsl:variable name="pos" select="@pct"/>
                  <xsl:variable name="cls">
                    <xsl:choose>
                      <xsl:when test="@pct='0'">tl-node first</xsl:when>
                      <xsl:when test="@pct='100'">tl-node last</xsl:when>
                      <xsl:otherwise>tl-node</xsl:otherwise>
                    </xsl:choose>
                  </xsl:variable>
                  <div class="{$cls}" style="left:{$pos}%">
                    <span class="tl-time"><xsl:value-of select="@time"/></span>
                    <span class="tl-label"><xsl:value-of select="@label"/></span>
                  </div>
                </xsl:for-each>
              </div>
            </div>
          </section>
          <!-- Deliverables -->
          <section class="section">
            <div class="section-label"><xsl:value-of select="Deliverables/@label"/></div>
            <div class="deliverables">
              <xsl:for-each select="Deliverables/Item">
                <xsl:variable name="cls">
                  <xsl:choose>
                    <xsl:when test="@full='true'">deliverable full</xsl:when>
                    <xsl:otherwise>deliverable</xsl:otherwise>
                  </xsl:choose>
                </xsl:variable>
                <div class="{$cls}">
                  <span class="d-num"><xsl:value-of select="@num"/></span>
                  <div>
                    <div class="d-tag"><xsl:value-of select="@tag"/></div>
                    <div class="d-title"><xsl:value-of select="@title"/></div>
                  </div>
                </div>
              </xsl:for-each>
            </div>
          </section>
          <!-- Byline + CTA -->
          <div class="bottom-row">
            <div class="byline">
              <img class="byline-photo" src="{Byline/@photo}" alt="{Byline/@name}"/>
              <div>
                <div class="byline-name"><xsl:value-of select="Byline/@name"/></div>
                <div class="byline-role"><xsl:value-of select="Byline/@role"/></div>
                <div class="byline-bio"><xsl:value-of select="Byline/@bio"/></div>
              </div>
            </div>
            <a class="cta-btn" href="{Byline/@cta-href}">
              <span class="cta-label"><xsl:value-of select="Byline/@cta-label"/></span>
              <span class="cta-hint"><xsl:value-of select="Byline/@cta-hint"/></span>
            </a>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- ═══════════════════════════════════════════════
       Assessment page — standalone root template
       Source: ai-readiness/index.xml
       ═══════════════════════════════════════════════ -->
  <xsl:template match="/AssessmentSite">
    <html lang="en">
      <head>
        <!-- Google Tag Manager -->
        <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&amp;l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-5TQXWR2M');</script>
        <!-- End Google Tag Manager -->
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>AI Readiness Navigator — Ajared Research Inc</title>
        <meta name="description" content="Discover where you are in your AI journey, set your goals, and get a personalized action plan. Assessment by Ajared Research Inc."/>
        <link rel="icon" type="image/x-icon" href="/favicon.ico"/>
        <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png"/>
        <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png"/>
        <link rel="apple-touch-icon" sizes="180x180" href="/favicon-32x32.png"/>
        <!-- Open Graph / Social sharing -->
        <meta property="og:type"         content="website"/>
        <meta property="og:url"          content="https://ajared.ca/ai-readiness/"/>
        <meta property="og:title"        content="AI Readiness Navigator — Ajared Research Inc"/>
        <meta property="og:description"  content="Find out your AI readiness level — Explorer, Activator, Builder, or Catalyst. 3-minute assessment with a personalized action plan."/>
        <meta property="og:image"        content="https://ajared.ca/ai-readiness/og-card.png"/>
        <meta property="og:image:width"  content="1200"/>
        <meta property="og:image:height" content="628"/>
        <!-- Twitter / X card -->
        <meta name="twitter:card"        content="summary_large_image"/>
        <meta name="twitter:site"        content="@ajared"/>
        <meta name="twitter:title"       content="AI Readiness Navigator — Ajared Research Inc"/>
        <meta name="twitter:description" content="Find out your AI readiness level in 3 minutes. Explorer, Activator, Builder, or Catalyst — with a personalized action plan."/>
        <meta name="twitter:image"       content="https://ajared.ca/ai-readiness/og-card.png"/>
        <link rel="stylesheet" href="/ai-readiness/assessment.css"/>
      </head>
      <body>
        <!-- Google Tag Manager (noscript) -->
        <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-5TQXWR2M"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
        <!-- End Google Tag Manager (noscript) -->

        <!-- Header -->
        <header class="site-header">
          <a href="/">
            <img src="/logo.png" alt="Ajared Research Inc"/>
            <span class="wordmark">Research Inc.</span>
          </a>
          <nav class="header-nav">
            <a href="/">&#8592; Back to site</a>
          </nav>
        </header>

        <!-- ═══════════ QUIZ SECTION ═══════════ -->
        <div id="quiz-section">
          <section class="hero">
            <div class="hero-label">Assessment</div>
            <h1>AI Readiness Navigator</h1>
            <p>Discover where you are in your AI journey, understand your goals, and get a personalized action plan. Takes about 3 minutes.</p>
          </section>
          <div class="progress-bar" id="progress-bar"></div>
          <div class="questions-container" id="questions-container"></div>
          <div class="submit-area">
            <button class="btn-primary" id="btn-submit" disabled="disabled" onclick="showLeadCapture()">See My Results</button>
            <div class="submit-hint" id="submit-hint">Answer all questions to continue</div>
          </div>
        </div>

        <!-- ═══════════ LEAD CAPTURE ═══════════ -->
        <div class="lead-section" id="lead-section">
          <svg class="lead-geo" viewBox="0 0 800 600" preserveAspectRatio="xMidYMid slice" xmlns="http://www.w3.org/2000/svg">
            <g transform="translate(620,300)" fill="none" stroke="#058c8c" stroke-width="1">
              <circle r="60"/><circle r="120"/><circle r="180"/><circle r="240"/><circle r="300"/><circle r="380"/>
            </g>
            <g stroke="#058c8c" stroke-width="1" opacity="0.7">
              <line x1="620" y1="0"   x2="620" y2="600"/>
              <line x1="320" y1="300" x2="920" y2="300"/>
              <line x1="407" y1="87"  x2="833" y2="513"/>
              <line x1="407" y1="513" x2="833" y2="87"/>
            </g>
            <g stroke="#058c8c" stroke-width="1.2" opacity="0.6">
              <line x1="119" y1="115" x2="121" y2="115"/><line x1="120" y1="114" x2="120" y2="116"/>
              <line x1="239" y1="115" x2="241" y2="115"/><line x1="240" y1="114" x2="240" y2="116"/>
              <line x1="359" y1="115" x2="361" y2="115"/><line x1="360" y1="114" x2="360" y2="116"/>
              <line x1="479" y1="115" x2="481" y2="115"/><line x1="480" y1="114" x2="480" y2="116"/>
              <line x1="119" y1="235" x2="121" y2="235"/><line x1="120" y1="234" x2="120" y2="236"/>
              <line x1="239" y1="235" x2="241" y2="235"/><line x1="240" y1="234" x2="240" y2="236"/>
              <line x1="359" y1="235" x2="361" y2="235"/><line x1="360" y1="234" x2="360" y2="236"/>
              <line x1="119" y1="355" x2="121" y2="355"/><line x1="120" y1="354" x2="120" y2="356"/>
              <line x1="239" y1="355" x2="241" y2="355"/><line x1="240" y1="354" x2="240" y2="356"/>
              <line x1="359" y1="355" x2="361" y2="355"/><line x1="360" y1="354" x2="360" y2="356"/>
              <line x1="479" y1="355" x2="481" y2="355"/><line x1="480" y1="354" x2="480" y2="356"/>
              <line x1="119" y1="475" x2="121" y2="475"/><line x1="120" y1="474" x2="120" y2="476"/>
              <line x1="239" y1="475" x2="241" y2="475"/><line x1="240" y1="474" x2="240" y2="476"/>
              <line x1="359" y1="475" x2="361" y2="475"/><line x1="360" y1="474" x2="360" y2="476"/>
            </g>
            <g fill="#a1665e">
              <circle cx="120" cy="120" r="2.5"/>
              <circle cx="360" cy="480" r="2.5"/>
              <circle cx="480" cy="240" r="2.5"/>
              <circle cx="240" cy="360" r="2.5"/>
            </g>
          </svg>
          <div class="lead-card">
            <div class="lead-label">Almost there</div>
            <h2>Get Your Results</h2>
            <p>Enter your details to see your AI readiness profile and get a personalized action plan.</p>
            <form class="lead-form" id="lead-form" action="https://formspree.io/f/mwvrkwll" method="POST">
              <input type="hidden" name="assessment_level" id="hidden-level"/>
              <input type="hidden" name="assessment_score" id="hidden-score"/>
              <input type="hidden" name="assessment_answers" id="hidden-answers"/>
              <div class="form-field">
                <label for="lead-name">Name</label>
                <input type="text" id="lead-name" name="name" placeholder="Your name"/>
              </div>
              <div class="form-field">
                <label for="lead-email">Email</label>
                <input type="email" id="lead-email" name="email" placeholder="you@example.com" required="required"/>
              </div>
              <div class="form-error" id="form-error"></div>
              <button type="submit" class="btn-primary">Show My Results &#8594;</button>
            </form>
          </div>
        </div>

        <!-- ═══════════ RESULTS ═══════════ -->
        <div class="results-section" id="results-section">
          <div class="level-badge-container">
            <div class="level-badge" id="level-badge"></div>
            <div class="level-score" id="level-score"></div>
            <div class="level-score-label">AI Readiness Score</div>
            <p class="level-desc" id="level-desc"></p>
          </div>
          <div class="result-card">
            <div class="result-card-title">Your Profile</div>
            <div class="radar-container" id="radar-container"></div>
            <div class="dim-bars" id="dim-bars"></div>
          </div>
          <div class="result-card">
            <div class="result-card-title">Your Next Steps</div>
            <div id="next-steps"></div>
          </div>
          <div class="result-card" id="usecases-card" style="display:none;">
            <div class="result-card-title">Suggested AI Use Cases For You</div>
            <div id="usecases"></div>
          </div>
          <!-- Share Results -->
          <div class="result-card share-section" id="share-card-section">
            <div class="result-card-title">Share Your Results</div>
            
            <div class="share-card-preview" id="share-card-preview">
              <!-- decorative rings -->
              <div class="share-card-ring" style="width:600px;height:600px;right:-200px;top:-200px;"></div>
              <div class="share-card-ring" style="width:380px;height:380px;right:-100px;top:-100px;"></div>
              <div class="share-card-ring" style="width:200px;height:200px;right:-20px;top:-20px;"></div>

              <div class="share-card-inner" style="flex-direction:column; gap:20px;">
                <!-- top row: logo + radar -->
                <div style="display:flex; align-items:flex-start; justify-content:space-between; width:100%;">
                  <img src="/logo.png" alt="Ajared Research Inc" style="height:28px; width:auto; filter: brightness(0) invert(1); opacity:0.9;"/>
                  <svg class="share-card-radar" viewBox="0 0 120 120">
                    <circle cx="60" cy="60" r="50" fill="none" stroke="rgba(140,202,202,0.2)" stroke-width="1"/>
                    <circle cx="60" cy="60" r="35" fill="none" stroke="rgba(140,202,202,0.15)" stroke-width="1"/>
                    <circle cx="60" cy="60" r="20" fill="none" stroke="rgba(140,202,202,0.1)" stroke-width="1"/>
                    <line x1="60" y1="10" x2="60" y2="110" stroke="rgba(140,202,202,0.15)" stroke-width="1"/>
                    <line x1="10" y1="60" x2="110" y2="60" stroke="rgba(140,202,202,0.15)" stroke-width="1"/>
                    <line x1="25" y1="25" x2="95" y2="95" stroke="rgba(140,202,202,0.1)" stroke-width="1"/>
                    <line x1="95" y1="25" x2="25" y2="95" stroke="rgba(140,202,202,0.1)" stroke-width="1"/>
                    <polygon points="60,18 96,40 96,80 60,102 24,80 24,40" fill="rgba(5,140,140,0.25)" stroke="#8ccaca" stroke-width="1.5"/>
                  </svg>
                </div>

                <!-- bottom row: level + score + desc -->
                <div class="share-card-left" style="width:100%;">
                  <div class="share-card-eyebrow">AI Readiness Navigator</div>
                  <div class="share-card-level" id="share-card-level-text">Builder</div>
                  <div class="share-card-score"><span id="share-card-score-text">72%</span> · AI Readiness Score</div>
                  <div class="share-card-desc" id="share-card-desc-text">Actively integrating AI into workflows — next step is systematic implementation.</div>
                  <div class="share-card-branding" style="margin-top:20px;text-align:left;">
                    ajared.ca/<span style="color:var(--ink-light)">ai-readiness</span>
                  </div>
                </div>
              </div>
            </div>

            <div class="share-action-row">
              <span class="share-label">Share →</span>
              <button class="btn-share btn-share-linkedin" onclick="shareLinkedIn()">
                <svg viewBox="0 0 24 24" fill="currentColor"><path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433a2.062 2.062 0 0 1-2.063-2.065 2.064 2.064 0 1 1 2.063 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/></svg>
                LinkedIn
              </button>
              <button class="btn-share btn-share-x" onclick="shareX()">
                <svg viewBox="0 0 24 24" fill="currentColor"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-4.714-6.231-5.401 6.231H2.746l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg>
                Post on X
              </button>
              <button class="btn-share btn-share-download" onclick="downloadCard()">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
                Download Card
              </button>
              <button class="btn-share btn-share-copy" onclick="copyAssessmentLink()">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/></svg>
                Copy Link
              </button>
              <span class="copy-toast" id="copy-toast">Copied!</span>
            </div>
            <p class="share-hint">Link goes directly to the assessment so others can find out their level.</p>
          </div>
          <!-- CTA -->
          <div class="cta-block">
            <h3>Ready to accelerate your AI journey?</h3>
            <p>Book a 30-minute consultation to build your personalized AI roadmap.</p>
            <a href="https://cal.com/ajared" target="_blank" rel="noopener noreferrer" class="btn-cta">Book a Consultation</a>
          </div>
          <div class="retake-area">
            <button class="btn-retake" onclick="retake()">&#8635; Retake Assessment</button>
          </div>
        </div>

        <footer class="site-footer">
          <p>&#169; 2026 <a href="/">Ajared Research Inc.</a></p>
          <span class="footer-label">R<span style="color:#a1665e">e</span>s<span style="color:#a1665e">ea</span>rch,
            <span style="color:#a1665e">e</span>d<span style="color:#a1665e">u</span>c<span style="color:#a1665e">a</span>t<span style="color:#a1665e">e</span>, d<span style="color:#a1665e">e</span>s<span style="color:#a1665e">i</span>gn.</span>
        </footer>

        <script src="/ai-readiness/assessment.js" defer="defer"></script>
      </body>
    </html>
  </xsl:template>

  <!-- ═══════════════════════════════════════════════
       PostList — writing/posts index on case-studies page
       ═══════════════════════════════════════════════ -->
  <xsl:template match="PostList">
    <style>
      /* Posts index — lighter than the Case Studies hero: smaller heading,
         no min-height (so it peeks above the fold), no repeated swirl,
         and no leading id column on each row. */
      .post-hero { min-height: auto; }
      .post-hero .hero-text { padding: 2.5rem 2rem 2rem; }
      .post-hero h1 { font-size: clamp(2.4rem, 6vw, 4rem); }
      .post-row { grid-template-columns: 2fr 1fr 0.5fr; }
      @media (max-width: 768px) { .post-row { grid-template-columns: 1fr; } }
    </style>
    <section class="hero-section post-hero">
      <div class="hero-text">
        <h1>Posts</h1>
      </div>
    </section>
    <div class="calibration-grid">
      <xsl:for-each select="PostEntry">
        <a href="{@href}" class="project-row post-row">
          <div class="project-main">
            <span class="project-meta"><xsl:value-of select="Tag"/></span>
            <span class="project-title"><xsl:value-of select="Title"/></span>
          </div>
          <span class="project-year"><xsl:value-of select="@date"/></span>
          <span style="text-align: right; color: var(--color-terra);">&#8599;</span>
        </a>
      </xsl:for-each>
    </div>
  </xsl:template>

  <!-- ═══════════════════════════════════════════════
       Article templates — long-form engineering posts
       Used by case-studies/*/index.xml
       ═══════════════════════════════════════════════ -->
  <xsl:template match="Article">
    <style>
      .article-wrap {
        max-width: 720px;
        margin: 0 auto;
        padding: 0 2rem;
        border-left: var(--grid-line);
        border-right: var(--grid-line);
        min-height: 60vh;
      }
      .article-hero {
        padding: 4rem 0 2.5rem;
        border-bottom: var(--grid-line);
      }
      .article-tag {
        font-family: var(--font-mono);
        font-size: 0.72rem;
        text-transform: uppercase;
        letter-spacing: 0.08em;
        color: var(--color-terra);
        display: block;
        margin-bottom: 1.4rem;
      }
      .article-title {
        font-size: clamp(1.9rem, 5vw, 3rem);
        font-weight: 700;
        letter-spacing: -0.03em;
        line-height: 1.08;
        margin-bottom: 1.4rem;
        color: var(--color-ink-darkest);
      }
      .article-desc {
        font-size: 1rem;
        line-height: 1.65;
        color: var(--color-ink-dark);
        max-width: 56ch;
        margin-bottom: 1.5rem;
      }
      .article-meta {
        font-family: var(--font-mono);
        font-size: 0.72rem;
        color: var(--color-ink-dark);
        letter-spacing: 0.05em;
      }
      .article-author {
        color: var(--color-ink-darkest);
        font-weight: 700;
      }
      .article-meta-sep { color: var(--color-ink-light); }
      .article-body {
        padding: 3rem 0 4rem;
      }
      .article-body p {
        line-height: 1.78;
        margin-bottom: 1.5rem;
        max-width: 66ch;
        color: var(--color-ink-dark);
      }
      .article-body h2 {
        font-size: 0.88rem;
        font-weight: 700;
        letter-spacing: 0.06em;
        text-transform: uppercase;
        color: var(--color-ink-darkest);
        margin: 3.5rem 0 1.2rem;
      }
      .article-body h3 {
        font-size: 1.1rem;
        font-weight: 700;
        letter-spacing: -0.01em;
        color: var(--color-ink-darkest);
        margin: 2.5rem 0 1rem;
      }
      .article-body h2 a,
      .article-body h3 a {
        color: inherit;
        text-decoration: none;
      }
      .article-body code {
        font-family: var(--font-mono);
        font-size: 0.88em;
        color: var(--color-terra);
        background: #f9f6f5;
        padding: 0.1em 0.35em;
        border-radius: 2px;
      }
      .article-body img {
        width: 100%;
        height: auto;
        border: var(--grid-line);
        margin: 2rem 0;
        display: block;
      }
      .article-body a {
        color: var(--color-ink);
        text-decoration: underline;
        text-decoration-color: var(--color-ink-lighter);
        text-underline-offset: 2px;
      }
      .article-body a:hover {
        text-decoration-color: var(--color-ink);
      }
      .article-body hr { border: none; border-top: var(--grid-line); margin: 2.5rem 0; }
      .article-body em {
        font-style: italic;
        color: var(--color-ink-dark);
      }
      .article-body strong {
        font-weight: 700;
      }
    </style>
    <div class="article-wrap">
      <xsl:apply-templates select="ArticleHero"/>
      <xsl:apply-templates select="ArticleBody"/>
    </div>
  </xsl:template>

  <xsl:template match="ArticleHero">
    <div class="article-hero">
      <span class="article-tag"><xsl:value-of select="Tag"/></span>
      <h1 class="article-title"><xsl:value-of select="Title"/></h1>
      <p class="article-desc"><xsl:value-of select="Desc"/></p>
      <span class="article-meta">
        <xsl:if test="Author != ''">
          <span class="article-author">
            <xsl:choose>
              <xsl:when test="Author/@url != ''">
                <a href="{Author/@url}" rel="author"><xsl:value-of select="Author"/></a>
              </xsl:when>
              <xsl:otherwise><xsl:value-of select="Author"/></xsl:otherwise>
            </xsl:choose>
          </span>
          <span class="article-meta-sep"> · </span>
        </xsl:if>
        <xsl:value-of select="Date"/>
      </span>
    </div>
  </xsl:template>

  <xsl:template match="ArticleBody">
    <div class="article-body">
      <xsl:value-of select="." disable-output-escaping="yes"/>
    </div>
  </xsl:template>

</xsl:stylesheet>
