/**
 * build-posts.mjs
 * Run from: website/posts/  (cd posts && node build-posts.mjs)
 *
 * Uses Voxx core API to:
 *  1. Read markdown posts from posts/content/
 *  2. Render each post as an XML file at /posts/[slug]/index.xml
 *     (XSLT wraps it in the site layout — Voxx is BYOF here)
 *  3. Copy content assets (images) into each post directory
 *  4. Inject a PostList into case-studies/index.xml between markers
 */

import { getPosts, loadConfig, renderMarkdown } from '@prudentbird/voxx-core';
import {
  readFileSync,
  writeFileSync,
  mkdirSync,
  readdirSync,
  copyFileSync,
  existsSync,
} from 'fs';
import { join } from 'path';

const postsDir = process.cwd();           // website/posts/
const siteRoot = join(postsDir, '..');    // website/
const contentDir = join(postsDir, 'content');
const postsOutDir = postsDir;             // output lives alongside source in posts/
const caseStudiesXml = join(siteRoot, 'case-studies', 'index.xml');

// ── helpers ──────────────────────────────────────────────────────────────────

function escapeAttr(str = '') {
  return str.replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
}

function escapeXmlText(str = '') {
  return str.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
}

function safeCdata(html = '') {
  // CDATA sections cannot contain "]]>" — split them if needed
  return html.replace(/]]>/g, ']]]]><![CDATA[>');
}

function formatDate(iso) {
  const d = new Date(iso);
  return d.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric', timeZone: 'UTC' });
}

// Copy all non-markdown files (images, etc.) from content dir to post output dir
function copyContentAssets(outDir) {
  if (!existsSync(contentDir)) return;
  for (const file of readdirSync(contentDir)) {
    if (file.endsWith('.md')) continue;
    const src = join(contentDir, file);
    const dest = join(outDir, file);
    copyFileSync(src, dest);
  }
}

// ── XML generator ─────────────────────────────────────────────────────────────

function generatePostXml(post, html) {
  const slug = post.slug;
  const siteUrl = 'https://ajared.ca';
  const postUrl = `${siteUrl}/posts/${slug}/`;
  const dateIso = post.date;
  const dateHuman = formatDate(dateIso);
  const title = post.title;
  const desc = post.description || post.excerpt || '';
  const tag = post.category || (post.tags && post.tags[0]) || 'Post';
  const author = post.author || '';
  const breadcrumb = slug
    .split('-')
    .map((w) => w.charAt(0).toUpperCase() + w.slice(1))
    .join(' ');

  const schemaJson = JSON.stringify({
    '@context': 'https://schema.org',
    '@graph': [
      { '@type': 'Organization', '@id': `${siteUrl}/#organization`, 'name': 'Ajared Research Inc.', 'url': siteUrl },
      {
        '@type': 'BreadcrumbList',
        itemListElement: [
          { '@type': 'ListItem', position: 1, name: 'Home', item: siteUrl },
          { '@type': 'ListItem', position: 2, name: 'Posts', item: `${siteUrl}/posts/` },
          { '@type': 'ListItem', position: 3, name: title, item: postUrl },
        ],
      },
      {
        '@type': 'TechArticle',
        '@id': postUrl,
        headline: title,
        description: desc,
        datePublished: dateIso,
        author: { '@id': `${siteUrl}/#organization` },
        publisher: { '@id': `${siteUrl}/#organization` },
        url: postUrl,
        keywords: post.tags || [],
      },
    ],
  }, null, 2);

  return `<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="/site-renderer.xslt"?>
<Page id="post-${escapeAttr(slug)}"
      title="${escapeAttr(title)}"
      description="${escapeAttr(desc)}"
      url="${postUrl}">

  <Schema><![CDATA[${schemaJson}]]></Schema>

  <Header compact="true">
    <Nav>
      <Breadcrumbs parent-href="/posts/" parent-label="Posts">
        <Current>${escapeXmlText(breadcrumb)}</Current>
      </Breadcrumbs>
    </Nav>
  </Header>

  <Article>
    <ArticleHero>
      <Tag>${escapeXmlText(tag)}</Tag>
      <Title>${escapeXmlText(title)}</Title>
      <Desc>${escapeXmlText(desc)}</Desc>
      <Author>${escapeXmlText(author)}</Author>
      <Date>${dateHuman}</Date>
    </ArticleHero>
    <ArticleBody><![CDATA[${safeCdata(html)}]]></ArticleBody>
  </Article>

  <Footer email="innovation@ajared.ca" year="2026"/>

</Page>
`;
}

// ── PostList injection into case-studies/index.xml ────────────────────────────

const POSTS_START = '<!-- POSTS:START -->';
const POSTS_END   = '<!-- POSTS:END -->';

function generatePostEntries(posts) {
  return posts.map(post => {
    const href = `/posts/${post.slug}/`;
    const dateHuman = formatDate(post.date);
    const title = post.title;
    const excerpt = post.description || post.excerpt || '';
    const tag = post.category || (post.tags && post.tags[0]) || 'Post';
    return `    <PostEntry href="${escapeAttr(href)}" date="${escapeAttr(dateHuman)}">
      <Title>${escapeXmlText(title)}</Title>
      <Excerpt>${escapeXmlText(excerpt)}</Excerpt>
      <Tag>${escapeXmlText(tag)}</Tag>
    </PostEntry>`;
  }).join('\n');
}

function injectPostList(posts) {
  const xml = readFileSync(caseStudiesXml, 'utf-8');
  const start = xml.indexOf(POSTS_START);
  const end   = xml.indexOf(POSTS_END);

  if (start === -1 || end === -1) {
    console.warn('  [warn] PostList markers not found in case-studies/index.xml — skipping injection');
    return;
  }

  const before   = xml.slice(0, start + POSTS_START.length);
  const after    = xml.slice(end);
  const entries  = generatePostEntries(posts);
  const updated  = `${before}\n${entries}\n  ${after}`;

  writeFileSync(caseStudiesXml, updated, 'utf-8');
  console.log(`  Injected ${posts.length} post(s) into case-studies/index.xml`);
}

// ── main ──────────────────────────────────────────────────────────────────────

console.log('Building posts from Voxx...');

const config = await loadConfig({ cwd: postsDir });
const posts = await getPosts({ config });

for (const post of posts) {
  const slug = post.slug;
  const assetBase = `/posts/${slug}`;
  const outDir = join(postsOutDir, slug);

  mkdirSync(outDir, { recursive: true });

  // Re-render with resolved asset paths
  const { html } = await renderMarkdown(post.content, config, { assetBase });

  // Copy images and other assets
  copyContentAssets(outDir);

  // Write XML
  const xml = generatePostXml(post, html);
  writeFileSync(join(outDir, 'index.xml'), xml, 'utf-8');

  console.log(`  Generated /posts/${slug}/index.xml`);
}

injectPostList(posts);

console.log(`  Done. ${posts.length} post(s) processed.`);
