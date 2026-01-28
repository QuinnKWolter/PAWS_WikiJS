# PAWS Wiki Migration Scripts

These scripts implement the complete MediaWiki → WikiJS migration pipeline as specified in the handoff instructions.

## Scripts Overview

### `01_ensure_markdown.ps1`
Ensures every `.wiki` file has a corresponding `.md` file. Regenerates from `.wiki` if `.md` is missing or too small (< 10 bytes).

**Usage:**
```powershell
.\scripts\01_ensure_markdown.ps1 -WikiSrcDir ".\wiki-src"
```

**What it does:**
- Verifies Pandoc is installed
- Scans `wiki-src` for all `.wiki` files
- Checks if corresponding `.md` exists and is valid
- Regenerates missing or empty `.md` files using Pandoc
- Reports statistics

### `02_build_import_tree.ps1`
Builds the import tree structure with proper frontmatter for WikiJS.

**Usage:**
```powershell
.\scripts\02_build_import_tree.ps1 -WikiSrcDir ".\wiki-src" -ImportDir ".\content\import\pages"
```

**What it does:**
- Creates namespace directories in `content/import/pages/`
- Copies `.md` files to appropriate namespace folders
- Adds YAML frontmatter with title, namespace, and source filename
- Normalizes filenames to slugs (lowercase, keep underscores)
- Preserves existing frontmatter if present

### `03_rewrite_links.ps1`
Rewrites internal links to match WikiJS import structure.

**Usage:**
```powershell
.\scripts\03_rewrite_links.ps1 -ImportDir ".\content\import\pages" -ReportFile ".\IMPORT_REPORT.md"
```

**What it does:**
- Builds an index of all pages (by title, slug, etc.)
- Rewrites MediaWiki links: `[[Title]]`, `[[Title|Text]]`
- Handles namespace prefixes: `User:`, `Category:`, etc.
- Converts HTML wikilink classes from Pandoc
- Fixes relative wiki paths
- Marks missing links with `#missing:Title` format
- Generates `IMPORT_REPORT.md` with statistics

**Link patterns handled:**
- `[[Title]]` → `[Title](/import/ns_0/title)`
- `[[Title|Display Text]]` → `[Display Text](/import/ns_0/title)`
- `[[User:Name]]` → `[Name](/import/ns_2/name)`
- `<a href="..." class="wikilink">` → Markdown links
- `/wiki/Title` → `/import/ns_0/title`

### `04_cleanup_markdown.ps1`
Fixes obvious Markdown rendering issues.

**Usage:**
```powershell
.\scripts\04_cleanup_markdown.ps1 -ImportDir ".\content\import\pages"
```

**What it does:**
- Converts HTML `<br>` tags to newlines
- Converts `<pre>` blocks to fenced code blocks
- Removes MediaWiki directives (`__TOC__`, `__NOTOC__`)
- Removes `[[Category:...]]` at end of files
- Normalizes heading levels (prevents excessive jumps)
- Fixes unclosed code blocks
- Removes excessive blank lines

### `RUN_ALL.ps1`
Master script that runs the entire pipeline in sequence.

**Usage:**
```powershell
# Run all steps
.\scripts\RUN_ALL.ps1

# Skip specific steps
.\scripts\RUN_ALL.ps1 -SkipStep1 -SkipStep4

# Custom directories
.\scripts\RUN_ALL.ps1 -WikiSrcDir ".\wiki-src" -ImportDir ".\content\import\pages"
```

**What it does:**
- Verifies prerequisites (Pandoc, directories)
- Runs all 4 steps in sequence
- Provides progress updates
- Generates final summary
- Reports duration and statistics

## Quick Start

1. **Ensure prerequisites:**
   ```powershell
   # Check Pandoc
   pandoc --version
   ```

2. **Run the pipeline:**
   ```powershell
   .\scripts\RUN_ALL.ps1
   ```

3. **Review results:**
   - Check `content/import/pages/` for the import tree
   - Review `IMPORT_REPORT.md` for link statistics
   - Sample a few pages to verify formatting

4. **Import into WikiJS:**
   - Option A: Git storage (preferred)
     - Initialize git repo: `git init`
     - Add import tree: `git add content/import`
     - Commit: `git commit -m "Import PAWS wiki"`
     - Configure WikiJS to read from this repo
   - Option B: Bulk import via API
     - Use `import-to-wikijs.js` script
     - Or use WikiJS admin import tool

## Namespace Mapping

The scripts preserve all namespaces found in `wiki-src`:

| Namespace | MediaWiki Name | Typical Content | Import? |
|-----------|---------------|-----------------|---------|
| ns_0 | Main | Core wiki content | ✅ Yes |
| ns_1 | Talk | Discussion pages | ⚠️ Optional |
| ns_2 | User | User profile pages | ⚠️ Optional |
| ns_3 | User talk | User discussions | ❌ Usually skip |
| ns_4 | Project | Wiki meta pages | ❌ Usually skip |
| ns_6 | File | File descriptions | ❌ Usually skip |
| ns_8 | MediaWiki | System messages | ❌ Usually skip |
| ns_10 | Template | Templates | ❌ Usually skip |
| ns_14 | Category | Category pages | ⚠️ Optional |

All namespaces are imported by default. You can prune unwanted namespaces after import.

## Link Resolution

The link rewrite script attempts to resolve links using multiple strategies:

1. **Exact title match** (case-insensitive)
2. **Slug match** (filename-based)
3. **Namespace-aware matching** (for `User:`, `Category:`, etc.)
4. **Multiple lookup keys** per page (title, slug, variations)

Target resolution rate: ≥95%

Missing links are:
- Marked with `#missing:Title` format
- Logged in `IMPORT_REPORT.md`
- Can be manually fixed after import

## File Structure After Migration

```
content/import/pages/
├── ns_0/          # Main namespace
│   ├── adl.md
│   ├── mastery_grids.md
│   └── ...
├── ns_1/          # Talk namespace
│   └── ...
├── ns_2/          # User namespace
│   └── ...
└── ...
```

Each file contains:
- YAML frontmatter with metadata
- Clean Markdown content
- Rewritten internal links
- Proper heading structure

## Troubleshooting

### Pandoc not found
```powershell
# Install from: https://pandoc.org/installing.html
# Or use Chocolatey:
choco install pandoc
```

### Low link resolution rate
- Check `IMPORT_REPORT.md` for missing links
- Some links may need manual fixing
- Namespace mismatches may require adjustment

### Import tree not created
- Verify `wiki-src` directory exists
- Check that `.md` files exist (run Step 1 first)
- Ensure write permissions on `content/import/`

### Script errors
- Check PowerShell execution policy: `Get-ExecutionPolicy`
- If restricted, run: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`
- Verify all paths are correct (use absolute paths if needed)

## Idempotency

All scripts are designed to be **idempotent** - safe to run multiple times:
- Step 1: Only regenerates missing/empty `.md` files
- Step 2: Updates frontmatter but preserves content
- Step 3: Only rewrites links that need updating
- Step 4: Only fixes issues found

You can re-run any step without data loss.

## Next Steps After Migration

1. **Review import tree:**
   - Sample pages across namespaces
   - Check link resolution
   - Verify formatting

2. **Prune unwanted content:**
   - Remove namespaces you don't need (ns_1, ns_3, etc.)
   - Delete empty or broken pages

3. **Import into WikiJS:**
   - Use Git storage for version control
   - Or bulk import via API/CLI

4. **Post-import cleanup:**
   - Fix remaining broken links manually
   - Update categories/tags
   - Set page permissions
   - Configure redirects if needed

---

For detailed migration planning, see [MIGRATION_PLAN.md](../MIGRATION_PLAN.md)

