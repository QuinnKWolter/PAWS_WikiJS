# 04_cleanup_markdown_improved.ps1
# Comprehensive MediaWiki to Markdown cleanup

param(
    [string]$ImportDir = ".\content\import\pages",
    [switch]$RemoveFrontmatter
)

$ErrorActionPreference = "Stop"

Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Step 4: Improved Markdown Cleanup" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $ImportDir)) {
    Write-Host "ERROR: Import directory not found: $ImportDir" -ForegroundColor Red
    exit 1
}

$stats = @{
    FilesProcessed = 0
    FilesModified = 0
    MediaWikiHeaders = 0
    NewlineChars = 0
    MediaWikiDirectives = 0
    ListItems = 0
    BrokenLists = 0
    MultilineHeaders = 0
    FrontmatterRemoved = 0
}

$mdFiles = Get-ChildItem -Path $ImportDir -Recurse -Filter "*.md"

Write-Host "Processing $($mdFiles.Count) files..." -ForegroundColor Yellow
Write-Host ""

foreach ($mdFile in $mdFiles) {
    $stats.FilesProcessed++
    $content = Get-Content -Path $mdFile.FullName -Raw -Encoding UTF8
    $originalContent = $content
    $fileChanged = $false
    
    # Fix 1: Remove frontmatter if requested
    if ($RemoveFrontmatter) {
        if ($content -match '(?s)^---\s*\r?\n(.*?)\r?\n---\s*\r?\n(.*)$') {
            $content = $matches[2]
            $stats.FrontmatterRemoved++
            $fileChanged = $true
        }
    }
    
    # Fix 2: Convert literal \n to actual newlines (but preserve escaped ones)
    if ($content -match '(?<!\\)\\n') {
        # Replace \n with newline, but keep \\n as \n
        $content = $content -replace '(?<!\\)\\n', "`n"
        $content = $content -replace '\\\\n', '\\n'  # Restore double-escaped
        $stats.NewlineChars++
        $fileChanged = $true
    }
    
    # Fix 3: Fix multiline MediaWiki headers (== Header\nText ==)
    # First, find and fix headers split across lines
    if ($content -match '={2,6}\s+[^=]+\r?\n[^=]+\s+={2,6}') {
        $content = [regex]::Replace($content, '={2,6}\s+([^=\r\n]+)\r?\n\s*([^=\r\n]+)\s+={2,6}', {
            param($match)
            $line1 = $match.Groups[1].Value.Trim()
            $line2 = $match.Groups[2].Value.Trim()
            $equalsCount = ($match.Value -split '=').Count - 1
            $level = [math]::Min($equalsCount, 6)
            $stats.MultilineHeaders++
            $script:fileChanged = $true
            return ("#" * $level) + " $line1 $line2"
        }, [System.Text.RegularExpressions.RegexOptions]::Multiline)
        $fileChanged = $true
    }
    
    # Fix 4: Convert MediaWiki headers (== Header ==) to Markdown (# Header)
    if ($content -match '={2,6}\s+.+?\s+={2,6}') {
        $content = [regex]::Replace($content, '^(\s*)={2,6}\s+(.+?)\s+={2,6}\s*$', {
            param($match)
            $indent = $match.Groups[1].Value
            $headerText = $match.Groups[2].Value.Trim()
            $equalsCount = ($match.Value -split '=').Count - 1
            $level = [math]::Min($equalsCount, 6)
            $stats.MediaWikiHeaders++
            $script:fileChanged = $true
            return "$indent" + ("#" * $level) + " $headerText"
        }, [System.Text.RegularExpressions.RegexOptions]::Multiline)
        $fileChanged = $true
    }
    
    # Fix 5: Fix broken list items (asterisks on separate lines)
    # Pattern: *\n* (asterisk on one line, then another asterisk on next line)
    # Or: *\nText (asterisk followed by newline then text)
    if ($content -match '\*\s*\r?\n\s*\*') {
        # Fix: *\n* becomes * (merge consecutive list markers)
        $content = [regex]::Replace($content, '\*\s*\r?\n\s*\*', '*', [System.Text.RegularExpressions.RegexOptions]::Multiline)
        $stats.BrokenLists++
        $fileChanged = $true
    }
    
    # Fix: *\nText becomes * Text (merge list marker with following text)
    if ($content -match '\*\s*\r?\n\s+([^\*\r\n])') {
        $content = [regex]::Replace($content, '\*\s*\r?\n\s+([^\*\r\n#])', '* $1', [System.Text.RegularExpressions.RegexOptions]::Multiline)
        $stats.BrokenLists++
        $fileChanged = $true
    }
    
    # Fix 6: Remove MediaWiki directives
    if ($content -match '__TOC__|__NOTOC__') {
        $content = $content -replace '__TOC__|__NOTOC__', ''
        $stats.MediaWikiDirectives++
        $fileChanged = $true
    }
    
    # Also remove escaped versions
    if ($content -match '\\_\\_NOTOC\\_\\_') {
        $content = $content -replace '\\_\\_NOTOC\\_\\_', ''
        $stats.MediaWikiDirectives++
        $fileChanged = $true
    }
    
    # Fix 7: Convert \* to * for list items (but not in code blocks)
    # Protect code blocks first
    $codeBlockPattern = '```[^`]*?```'
    $codeBlocks = @()
    $placeholders = @()
    $protectedContent = $content
    
    $matches = [regex]::Matches($content, $codeBlockPattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    for ($i = 0; $i -lt $matches.Count; $i++) {
        $placeholder = "___CODEBLOCK_$i___"
        $codeBlocks += $matches[$i].Value
        $placeholders += $placeholder
        $protectedContent = $protectedContent -replace [regex]::Escape($matches[$i].Value), $placeholder
    }
    
    # Now fix escaped asterisks
    if ($protectedContent -match '\\\*') {
        $protectedContent = $protectedContent -replace '\\\*', '*'
        $stats.ListItems++
        $fileChanged = $true
    }
    
    # Restore code blocks
    for ($i = 0; $i -lt $codeBlocks.Count; $i++) {
        $protectedContent = $protectedContent -replace [regex]::Escape($placeholders[$i]), $codeBlocks[$i]
    }
    
    $content = $protectedContent
    
    # Fix 8: Clean up excessive blank lines (more than 2 consecutive)
    $content = [regex]::Replace($content, '\r?\n{4,}', "`n`n`n")
    
    # Fix 9: Remove trailing whitespace from lines
    $lines = $content -split "`n"
    $cleanedLines = @()
    foreach ($line in $lines) {
        $cleanedLines += $line.TrimEnd()
    }
    $content = $cleanedLines -join "`n"
    
    # Fix 10: Ensure proper spacing around headers
    $content = [regex]::Replace($content, '([^\r\n])\r?\n(#{1,6}\s)', '$1`n`n$2')
    $content = [regex]::Replace($content, '(#{1,6}\s[^\r\n]+)\r?\n([^\r\n#])', '$1`n`n$2')
    
    # Write back if changed
    if ($fileChanged -or $content -ne $originalContent) {
        $content | Out-File -FilePath $mdFile.FullName -Encoding UTF8 -NoNewline
        $stats.FilesModified++
        
        if ($stats.FilesModified % 50 -eq 0) {
            $msg = "  Processed " + $stats.FilesModified + " files..."
            Write-Host $msg -ForegroundColor Gray
        }
    }
}

Write-Host ""
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Summary" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Files processed:       $($stats.FilesProcessed)" -ForegroundColor White
Write-Host "Files modified:        $($stats.FilesModified)" -ForegroundColor Green
Write-Host ""
Write-Host "Fixes applied:" -ForegroundColor Cyan
Write-Host "  MediaWiki headers:   $($stats.MediaWikiHeaders)" -ForegroundColor White
Write-Host "  Multiline headers:   $($stats.MultilineHeaders)" -ForegroundColor White
Write-Host "  Newline characters:  $($stats.NewlineChars)" -ForegroundColor White
Write-Host "  MediaWiki directives: $($stats.MediaWikiDirectives)" -ForegroundColor White
Write-Host "  List items:          $($stats.ListItems)" -ForegroundColor White
Write-Host "  Broken lists fixed:  $($stats.BrokenLists)" -ForegroundColor White
if ($RemoveFrontmatter) {
    Write-Host "  Frontmatter removed: $($stats.FrontmatterRemoved)" -ForegroundColor White
}
Write-Host ""

Write-Host "[SUCCESS] Markdown cleanup complete" -ForegroundColor Green
exit 0

