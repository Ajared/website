<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" doctype-system="about:legacy-compat" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>

  <!-- Root template -->
  <xsl:template match="/Page">
    <html lang="en">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="icon" type="image/x-icon" href="/favicon.ico"/>
        <link rel="icon" type="image/svg+xml" href="/favicon.svg"/>
        <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png"/>
        <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png"/>
        <link rel="apple-touch-icon" sizes="180x180" href="/favicon-32x32.png"/>
        <title><xsl:value-of select="@title" /> — Ajared Research Inc</title>
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
            justify-content: space-between;
            min-height: 160px;
        }
            .form-section { grid-template-columns: 1fr; }
            .form-left { padding: 3rem 1rem; border-right: none; border-bottom: var(--grid-line); }
            .form-right { padding: 3rem 1rem; }
            .project-row { padding: 1.5rem 1.5rem; grid-template-columns: 40px 1fr; gap: 1rem; }
            .project-meta, .project-year { display: none; }



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
            border-right: var(--grid-line);
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
            content: '›';
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
        .form-left { padding: 4rem 2rem; border-right: var(--grid-line); }
        .form-right { padding: 4rem 2rem; background-image: radial-gradient(circle at 2px 2px, var(--color-ink-light) 1px, transparent 0); background-size: 40px 40px; }
        .instrument-field { margin-bottom: 3rem; position: relative; }
        .instrument-input { width: 100%; background: transparent; border: none; border-bottom: 2px solid var(--color-ink); color: var(--color-ink-darkest); font-family: var(--font-primary); font-size: 1rem; padding: 0.5rem 0; outline: none; cursor: crosshair; transition: border-color 0.3s ease, box-shadow 0.3s ease; }
        .instrument-input:focus { border-bottom-color: #a1665e; box-shadow: 0 1px 0 0 rgba(161, 102, 94, 0.2); }
        .instrument-input::placeholder { color: var(--color-ink-light); }
        .technical-markings { display: flex; justify-content: space-between; font-family: var(--font-mono); font-size: 10px; margin-top: 4px; color: var(--color-ink-light); }
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
        .project-row { grid-column: 1 / -1; display: grid; grid-template-columns: 80px 2fr 1.5fr 1fr 0.5fr; border-bottom: var(--grid-line); padding: 1.5rem 2rem; align-items: center; transition: background 0.3s, color 0.3s; text-decoration: none; color: inherit; }
        .project-row:hover { background: var(--color-ink); color: var(--color-bg); }
        .project-row:hover .project-id, .project-row:hover .project-title, .project-row:hover .project-meta, .project-row:hover .project-year { color: var(--color-bg); }
        .project-id { font-family: var(--font-mono); font-weight: 700; color: #a1665e; }
        .project-title { font-weight: 700; font-size: 1.5rem; text-transform: uppercase; color: var(--color-ink-darkest); }
        .project-meta { font-size: 0.9rem; text-transform: uppercase; letter-spacing: 0.05em; color: var(--color-ink-dark); }
        .project-year { font-family: var(--font-mono); text-align: right; color: var(--color-ink); }
</style>
        
        <!-- Inject any page-specific JSON-LD schemas from XML -->
        <xsl:if test="Schema">
            <script type="application/ld+json">
                <xsl:copy-of select="Schema/node()"/>
            </script>
        </xsl:if>
      </head>
      <body>
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
            <xsl:apply-templates select="StaticHero" />
            <xsl:apply-templates select="ProjectList" />
            
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
      </body>
    </html>
  </xsl:template>

  <!-- Component Templates -->
  <xsl:template match="Header">
    <header>
      <div class="header-cell" style="justify-content: flex-start; gap: 0;">
          <span class="label" style="color: var(--color-ink);">Information Architecture</span>
          <a href="/" style="text-decoration: none;">
              <img src="/logo.png" alt="Ajared Logo" style="height: 60px; width: auto; display: block; margin-bottom: 0.4rem;" />
              <div class="logo-text" style="line-height: 1.1;">Research Inc.</div>
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
              <div style="margin-top:auto">
                  <span class="label">Status</span>
                  <p><span style="display:inline-block; width:7px; height:7px; border-radius:50%; background:var(--color-terra); margin-right:7px; vertical-align:middle; position:relative; top:-1px;"></span><span style="color: var(--color-terra);">Open for Collaboration</span></p>
              </div>
            </xsl:otherwise>
          </xsl:choose>
      </div>
      <div class="header-cell">
          <span class="label">Navigation</span>
          <xsl:apply-templates select="Nav" />
          
          <xsl:choose>
            <xsl:when test="Nav/@arrow">
              <div style="margin-top: auto; font-size: 2rem; line-height: 1; color: var(--color-terra);"><xsl:value-of select="Nav/@arrow"/></div>
            </xsl:when>
            <xsl:otherwise>
              <div style="margin-top: auto; font-size: 2rem; line-height: 1; color: var(--color-terra);">↗</div>
            </xsl:otherwise>
          </xsl:choose>
      </div>
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
            <a href="{CTA/@href}" class="btn"><xsl:value-of select="CTA"/></a>
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
                  <div class="technical-markings">
                      <span>MIN_LEN: 2</span><span>TYPE: STRING</span><span>MAX_LEN: 128</span>
                  </div>
              </div>
              <div class="instrument-field">
                  <span class="label">02 / Email</span>
                  <input type="email" name="email" required="required" class="instrument-input" placeholder="your-email@domain.com" />
                  <div class="technical-markings">
                      <span>VAL: SMTP</span><span>PRIORITY: HIGH</span>
                  </div>
              </div>
              <div class="instrument-field" id="deliverable-field" style="display: none;">
                  <span class="label">03 / Specific Deliverable (Optional)</span>
                  <select name="deliverable" id="deliverable-select" class="instrument-input" style="cursor: crosshair;">
                      <option value="">Select a deliverable...</option>
                  </select>
                  <div class="technical-markings">
                      <span>DYNAMIC</span><span>TYPE: SELECT</span><span>OPTIONAL</span>
                  </div>
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
          <div class="instrument-field">
              <span class="label">04 / Origin Coordinates</span>
              <p style="margin-bottom: 1rem;">Where are you based?</p>
              <div class="coordinate-selector" id="coord-map">
                  <div class="crosshair-v" id="ch-v"></div>
                  <div class="crosshair-h" id="ch-h"></div>
              </div>
              <div class="technical-markings" style="margin-top: 10px;">
                  <span id="coord-display">LAT: 0.0000 / LONG: 0.0000</span>
              </div>
          </div>
          <div class="instrument-field" style="margin-top: 4rem;">
              <span class="label">System Status</span>
              <div class="status-indicator">
                  <div class="status-light"></div>
                  <p style="text-transform: uppercase; font-size: 0.9rem; letter-spacing: 0.1em;">Awaiting Input Signal...</p>
              </div>
          </div>
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
        <span class="project-title"><xsl:value-of select="Title"/></span>
        <span class="project-meta"><xsl:value-of select="Meta"/></span>
        <span class="project-year"><xsl:value-of select="Year"/></span>
        <span style="text-align: right; color: var(--color-terra);">↗</span>
    </a>
  </xsl:template>

</xsl:stylesheet>
