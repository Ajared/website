#!/usr/bin/env bash
# Finds all .xml files and compiles them to .html using xsltproc

echo "Building site with xsltproc..."

find . -type f -name "*.xml" -not -path "./node_modules/*" | while read xml_file; do
    html_file="${xml_file%.xml}.html"
    echo "Compiling $xml_file -> $html_file"
    xsltproc site-renderer.xslt "$xml_file" > "$html_file"
done

echo "Build complete."
