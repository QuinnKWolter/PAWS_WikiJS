# 04_cleanup_markdown.ps1
# Fixes obvious Markdown rendering issues

param(
    [string]$ImportDir = ".\content\import\pages"
)

$ErrorActionPreference = "Stop"

Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Step 4: Cleanup Markdown" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $ImportDir)) {
    Write-Host "ERROR: Import directory not found: $ImportDir" -ForegroundColor Red
    exit 1
}

$stats = @{
    FilesProcessed = 0
    FilesModified = 0
    FixesApplied = @{
        HtmlBr = 0
        PreBlocks = 0
        MediaWikiDirectives = 0
        HeadingLevels = 0
        MediaWikiHeaders = 0
        NewlineChars = 0
        Other = 0
    }
}

$mdFiles = Get-ChildItem -Path $ImportDir -Recurse -Filter "*.md"

Write-Host "Processing $($mdFiles.Count) files..." -ForegroundColor Yellow
Write-Host ""

foreach ($mdFile in $mdFiles) {
    $stats.FilesProcessed++
    $content = Get-Content -Path $mdFile.FullName -Raw -Encoding UTF8
    $originalContent = $content
    $fileChanged = $false
    
    # Fix 1: Convert literal \n to actual newlines (but not in code blocks)
    # First, protect code blocks
    $codeBlockPattern = '```[^`]*?```'
    $codeBlocks = [regex]::Matches($content, $codeBlockPattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    $codeBlockPlaceholders = @()
    $protectedContent = $content
    
    for ($i = 0; $i -lt $codeBlocks.Count; $i++) {
        $placeholder = "___CODEBLOCK_$i___"
        $codeBlockPlaceholders += $codeBlocks[$i].Value
        $protectedContent = $protectedContent -replace [regex]::Escape($codeBlocks[$i].Value), $placeholder
    }
    
    # Replace \n with actual newlines (but not \\n which is escaped)
    if ($protectedContent -match '\\n') {
        $protectedContent = $protectedContent -replace '(?<!\\)\\n', "`n"
        $protectedContent = $protectedContent -replace '\\\\n', '\n'  # Restore escaped newlines
        $stats.FixesApplied.NewlineChars++
        $fileChanged = $true
    }
    
    # Restore code blocks
    for ($i = 0; $i -lt $codeBlockPlaceholders.Count; $i++) {
        $protectedContent = $protectedContent -replace "___CODEBLOCK_$i___", $codeBlockPlaceholders[$i]
    }
    
    $content = $protectedContent
    
    # Fix 2: Convert MediaWiki headers (== Header ==) to Markdown (# Header)
    # Handle == Header ==, === Header ===, etc.
    $content = [regex]::Replace($content, '^(\s*)={2,6}\s+(.+?)\s+={2,6}\s*$', {
        param($match)
        $indent = $match.Groups[1].Value
        $headerText = $match.Groups[2].Value
        $level = [math]::Min(($match.Value -split '=').Count - 1, 6)
        $stats.FixesApplied.MediaWikiHeaders++
        $script:fileChanged = $true
        return "$indent" + ("#" * $level) + " $headerText"
    }, [System.Text.RegularExpressions.RegexOptions]::Multiline)
    
    # Fix 3: Convert HTML <br> and <br/> to newlines (where safe)
    $content = [regex]::Replace($content, '(?<!```[^`]*?)(?<!`)<br\s*/?>(?![^`]*?```)', {
        $stats.FixesApplied.HtmlBr++
        $script:fileChanged = $true
        return "`n"
    })
    
    # Fix 4: Convert <pre> blocks to fenced code blocks
    $content = [regex]::Replace($content, '<pre[^>]*>(.*?)</pre>', {
        param($match)
        $codeContent = $match.Groups[1].Value
        $stats.FixesApplied.PreBlocks++
        $script:fileChanged = $true
        return "````n$codeContent````n"
    }, [System.Text.RegularExpressions.RegexOptions]::Singleline -bor [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    
    # Fix 5: Remove MediaWiki directives
    # __TOC__, __NOTOC__
    if ($content -match '__TOC__|__NOTOC__') {
        $content = $content -replace '__TOC__|__NOTOC__', ''
        $stats.FixesApplied.MediaWikiDirectives++
        $fileChanged = $true
    }
    
    # Remove [[Category:...]] at the end (but keep as text if in body)
    if ($content -match '\[\[Category:[^\]]+\]\]\s*$') {
        $content = $content -replace '\[\[Category:[^\]]+\]\]\s*$', ''
        $stats.FixesApplied.MediaWikiDirectives++
        $fileChanged = $true
    }
    
    # Fix 6: Normalize heading levels (ensure they start at # and don't jump)
    $lines = $content -split "`n"
    $newLines = @()
    $lastHeadingLevel = 0
    
    foreach ($line in $lines) {
        if ($line -match '^(#{1,6})\s+(.+)$') {
            $level = $matches[1].Length
            $text = $matches[2].Trim()
            
            # If heading level jumps by more than 1, normalize
            if ($lastHeadingLevel -gt 0 -and $level -gt $lastHeadingLevel + 1) {
                $level = $lastHeadingLevel + 1
                $stats.FixesApplied.HeadingLevels++
                $fileChanged = $true
            }
            
            $newLines += ('#' * $level) + " $text"
            $lastHeadingLevel = $level
        } else {
            $newLines += $line
            if ($line.Trim() -ne '') {
                $lastHeadingLevel = 0  # Reset after non-heading content
            }
        }
    }
    
    if ($fileChanged) {
        $content = $newLines -join "`n"
    }
    
    # Fix 7: Remove excessive blank lines (more than 2 consecutive)
    $content = [regex]::Replace($content, '\r?\n{4,}', "`n`n`n")
    
    # Fix 8: Ensure code blocks are properly fenced
    $codeBlockCount = ([regex]::Matches($content, '```')).Count
    if ($codeBlockCount % 2 -ne 0) {
        # Odd number of fences - try to close
        $content += "`n```"
        $stats.FixesApplied.Other++
        $fileChanged = $true
    }
    
    # Fix 9: Remove literal \* from lists (MediaWiki list syntax)
    # This converts \* to * for list items
    if ($content -match '\\\*') {
        $content = $content -replace '\\\*', '*'
        $stats.FixesApplied.Other++
        $fileChanged = $true
    }
    
    # Write back if changed
    if ($fileChanged) {
        $content | Out-File -FilePath $mdFile.FullName -Encoding UTF8 -NoNewline
        $stats.FilesModified++
        
        if ($stats.FilesModified % 50 -eq 0) {
            Write-Host "  Processed $($stats.FilesModified) files..." -ForegroundColor Gray
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
Write-Host "  HTML br tags:        $($stats.FixesApplied.HtmlBr)" -ForegroundColor White
Write-Host "  pre blocks:          $($stats.FixesApplied.PreBlocks)" -ForegroundColor White
Write-Host "  MediaWiki directives: $($stats.FixesApplied.MediaWikiDirectives)" -ForegroundColor White
Write-Host "  MediaWiki headers:   $($stats.FixesApplied.MediaWikiHeaders)" -ForegroundColor White
Write-Host "  Newline characters:  $($stats.FixesApplied.NewlineChars)" -ForegroundColor White
Write-Host "  Heading levels:      $($stats.FixesApplied.HeadingLevels)" -ForegroundColor White
Write-Host "  Other fixes:         $($stats.FixesApplied.Other)" -ForegroundColor White
Write-Host ""

Write-Host "[SUCCESS] Markdown cleanup complete" -ForegroundColor Green
exit 0
