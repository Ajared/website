#!/usr/bin/env bash
# Finds all .xml files and compiles them to .html
# Uses xsltproc if available, falls back to Python lxml

set -euo pipefail

SITE_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if command -v xsltproc &>/dev/null; then
    echo "Building site with xsltproc..."
    find "$SITE_ROOT" -type f -name "*.xml" -not -path "*/node_modules/*" \
        -not -name "sitemap.xml" -not -name "site-renderer.xslt" | while read -r xml_file; do
        # Only compile files with a Page root element
        if grep -q '<Page ' "$xml_file"; then
            html_file="${xml_file%.xml}.html"
            echo "  Compiling $xml_file -> $html_file"
            xsltproc "$SITE_ROOT/site-renderer.xslt" "$xml_file" > "$html_file"
        fi
    done
else
    echo "xsltproc not found — using Python lxml fallback..."
    python3 - "$SITE_ROOT" <<'PYEOF'
import sys
from lxml import etree
import glob

site_root = sys.argv[1]
xslt_doc  = etree.parse(f"{site_root}/site-renderer.xslt")
transform = etree.XSLT(xslt_doc)

SKIP = {"sitemap.xml", "site-renderer.xslt"}

for xml_path in glob.glob(f"{site_root}/**/*.xml", recursive=True):
    if any(xml_path.endswith(s) for s in SKIP):
        print(f"  SKIP {xml_path}")
        continue
    try:
        doc = etree.parse(xml_path)
        if doc.getroot().tag != "Page":
            print(f"  SKIP {xml_path} (not a Page)")
            continue
        result = transform(doc)
        html_path = xml_path.replace(".xml", ".html")
        with open(html_path, "wb") as f:
            f.write(etree.tostring(result, pretty_print=True, method="html"))
        print(f"  OK  {html_path}")
    except Exception as e:
        print(f"  ERR {xml_path}: {e}", file=sys.stderr)
        sys.exit(1)
PYEOF
fi

echo "Build complete."
