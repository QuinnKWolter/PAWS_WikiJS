# Migration Scripts

This directory contains scripts for converting and importing content from MediaWiki to WikiJS.

## New Migration Pipeline (Recommended)

If you have a `wiki-src` directory with `.wiki` and `.md` files already converted, use the new migration pipeline:

**See [MIGRATION_SCRIPTS.md](MIGRATION_SCRIPTS.md) for complete documentation.**

Quick start:
```powershell
.\scripts\RUN_ALL.ps1
```

This will:
1. Ensure all `.md` files exist
2. Build import tree with frontmatter
3. Rewrite internal links
4. Cleanup markdown issues

## Legacy Scripts (XML Dump Conversion)

The following scripts are for converting from MediaWiki XML dumps:

## Scripts

### `convert-mediawiki.sh` / `convert-mediawiki.ps1`
Converts a MediaWiki XML dump to Markdown files using Pandoc.

**Usage:**
```bash
# Linux/Mac
./convert-mediawiki.sh mediawiki-dump.xml content/pages

# Windows PowerShell
.\convert-mediawiki.ps1 -InputXml mediawiki-dump.xml -OutputDir content\pages
```

**Prerequisites:**
- Pandoc installed (https://pandoc.org/installing.html)
- Python 3 (for XML parsing)
- MediaWiki XML dump file

**What it does:**
1. Extracts pages from MediaWiki XML dump
2. Converts each page from MediaWiki syntax to Markdown
3. Saves converted files to the output directory

### `fix-links.py`
Fixes internal links in converted Markdown files.

**Usage:**
```bash
python fix-links.py content/pages [options]
```

**Options:**
- `--dry-run`: Show what would be changed without making changes
- `--verbose`: Show detailed output
- `--report`: Generate a report of broken links

**What it does:**
1. Scans all Markdown files for MediaWiki-style links
2. Converts them to Markdown link format
3. Attempts to resolve internal links to actual pages
4. Marks broken links with comments
5. Generates a report of broken links (optional)

### `import-to-wikijs.js`
Imports Markdown files into WikiJS using the API.

**Usage:**
```bash
node import-to-wikijs.js <api-key> <content-dir> [options]
```

**Options:**
- `--dry-run`: Show what would be imported without importing
- `--verbose`: Show detailed output
- `--batch-size=N`: Number of files per batch (default: 10)

**Prerequisites:**
- WikiJS running and accessible
- API key with write permissions
- Node.js installed

**To get an API key:**
1. Log into WikiJS as admin
2. Go to **Administration → API**
3. Create a new API key with write permissions

**What it does:**
1. Reads all Markdown files from the content directory
2. Parses frontmatter (if present) for metadata
3. Creates pages in WikiJS via API
4. Handles errors and provides progress updates

## Workflow

1. **Export from MediaWiki**
   ```bash
   # Use MediaWiki's dumpBackup.php or Special:Export
   ```

2. **Convert to Markdown**
   ```bash
   ./convert-mediawiki.sh mediawiki-dump.xml content/pages
   ```

3. **Fix Links**
   ```bash
   python fix-links.py content/pages --verbose --report
   ```

4. **Review and Edit**
   - Check the broken links report
   - Manually fix any issues
   - Review converted content

5. **Import to WikiJS**
   ```bash
   # First, test with dry-run
   node import-to-wikijs.js YOUR_API_KEY content/pages --dry-run
   
   # Then import for real
   node import-to-wikijs.js YOUR_API_KEY content/pages
   ```

## Notes

- Always test with a small subset first
- Keep backups of original MediaWiki content
- Review converted content before importing
- Fix broken links manually if needed
- Some MediaWiki templates may need manual conversion

