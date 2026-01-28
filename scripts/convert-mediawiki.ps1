# Convert MediaWiki XML dump to Markdown files (PowerShell version)
# Usage: .\convert-mediawiki.ps1 -InputXml <input.xml> -OutputDir <output-dir>

param(
    [string]$InputXml = "mediawiki-dump.xml",
    [string]$OutputDir = "content\pages"
)

Write-Host "Converting MediaWiki dump: $InputXml" -ForegroundColor Cyan
Write-Host "Output directory: $OutputDir" -ForegroundColor Cyan

# Create output directory
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

# Check if pandoc is installed
if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    Write-Host "Error: pandoc is not installed" -ForegroundColor Red
    Write-Host "Install it from: https://pandoc.org/installing.html" -ForegroundColor Yellow
    exit 1
}

# Check if Python is available (for XML parsing)
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "Warning: Python not found. You may need to install it for XML parsing." -ForegroundColor Yellow
    Write-Host "Alternatively, use the MediaWiki Special:Export feature to export pages individually." -ForegroundColor Yellow
}

# Create temp directory
$TempDir = New-TemporaryFile | ForEach-Object { Remove-Item $_; New-Item -ItemType Directory -Path $_ }

Write-Host "Temp directory: $TempDir" -ForegroundColor Gray

# Extract pages from XML dump using Python
Write-Host "Extracting pages from XML..." -ForegroundColor Cyan

$pythonScript = @"
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
"@

if (Get-Command python -ErrorAction SilentlyContinue) {
    python -c $pythonScript $InputXml $OutputDir $TempDir
} else {
    Write-Host "Python not available. Please extract pages manually or install Python." -ForegroundColor Red
    exit 1
}

# Convert each MediaWiki file to Markdown
Write-Host "Converting to Markdown..." -ForegroundColor Cyan
$converted = 0
$failed = 0

Get-ChildItem -Path $TempDir -Filter "*.mw" | ForEach-Object {
    $basename = $_.BaseName
    $outputFile = Join-Path $OutputDir "$basename.md"
    
    try {
        pandoc -f mediawiki -t markdown $_.FullName -o $outputFile 2>$null
        $script:converted++
    } catch {
        Write-Host "Warning: Failed to convert $basename" -ForegroundColor Yellow
        $script:failed++
    }
    
    if (($converted + $failed) % 50 -eq 0) {
        Write-Host "Converted: $converted, Failed: $failed" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "Conversion complete!" -ForegroundColor Green
Write-Host "Successfully converted: $converted files" -ForegroundColor Green
Write-Host "Failed: $failed files" -ForegroundColor $(if ($failed -gt 0) { "Yellow" } else { "Green" })
Write-Host "Output directory: $OutputDir" -ForegroundColor Cyan

# Cleanup
Remove-Item -Path $TempDir -Recurse -Force

