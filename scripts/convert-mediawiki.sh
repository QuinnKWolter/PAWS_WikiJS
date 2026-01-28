#!/bin/bash
#
# Convert MediaWiki XML dump to Markdown files
# Usage: ./convert-mediawiki.sh <input.xml> <output-dir>
#

set -e

INPUT_XML="${1:-mediawiki-dump.xml}"
OUTPUT_DIR="${2:-content/pages}"
TEMP_DIR=$(mktemp -d)

echo "Converting MediaWiki dump: $INPUT_XML"
echo "Output directory: $OUTPUT_DIR"
echo "Temp directory: $TEMP_DIR"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo "Error: pandoc is not installed"
    echo "Install it from: https://pandoc.org/installing.html"
    exit 1
fi

# Extract pages from XML dump
echo "Extracting pages from XML..."
python3 << 'PYTHON_SCRIPT'
import xml.etree.ElementTree as ET
import sys
import os

input_file = sys.argv[1]
output_dir = sys.argv[2]
temp_dir = sys.argv[3]

os.makedirs(output_dir, exist_ok=True)
os.makedirs(temp_dir, exist_ok=True)

tree = ET.parse(input_file)
root = tree.getroot()

# MediaWiki namespace
ns = {'mw': 'http://www.mediawiki.org/xml/export-0.11/'}

count = 0
for page in root.findall('.//mw:page', ns):
    title_elem = page.find('mw:title', ns)
    if title_elem is None:
        continue
    
    title = title_elem.text
    if not title:
        continue
    
    # Get the latest revision
    revision = page.find('.//mw:revision', ns)
    if revision is None:
        continue
    
    text_elem = revision.find('mw:text', ns)
    if text_elem is None or not text_elem.text:
        continue
    
    # Sanitize filename
    safe_title = "".join(c for c in title if c.isalnum() or c in (' ', '-', '_')).strip()
    safe_title = safe_title.replace(' ', '_')
    
    # Save to temp file
    temp_file = os.path.join(temp_dir, f"{safe_title}.mw")
    with open(temp_file, 'w', encoding='utf-8') as f:
        f.write(text_elem.text)
    
    count += 1
    if count % 100 == 0:
        print(f"Extracted {count} pages...", file=sys.stderr)

print(f"Extracted {count} pages", file=sys.stderr)
PYTHON_SCRIPT
"$INPUT_XML" "$OUTPUT_DIR" "$TEMP_DIR"

# Convert each MediaWiki file to Markdown
echo "Converting to Markdown..."
converted=0
failed=0

for mw_file in "$TEMP_DIR"/*.mw; do
    if [ ! -f "$mw_file" ]; then
        continue
    fi
    
    basename=$(basename "$mw_file" .mw)
    output_file="$OUTPUT_DIR/${basename}.md"
    
    if pandoc -f mediawiki -t markdown "$mw_file" -o "$output_file" 2>/dev/null; then
        converted=$((converted + 1))
    else
        echo "Warning: Failed to convert $basename"
        failed=$((failed + 1))
    fi
    
    if [ $((converted + failed)) -eq 0 ] || [ $((converted + failed)) % 50 -eq 0 ]; then
        echo "Converted: $converted, Failed: $failed"
    fi
done

echo ""
echo "Conversion complete!"
echo "Successfully converted: $converted files"
echo "Failed: $failed files"
echo "Output directory: $OUTPUT_DIR"

# Cleanup
rm -rf "$TEMP_DIR"

