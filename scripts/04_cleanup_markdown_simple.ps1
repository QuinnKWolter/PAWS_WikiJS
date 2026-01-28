# 04_cleanup_markdown_simple.ps1
# Fixes MediaWiki to Markdown conversion issues

param(
    [string]$ImportDir = ".\content\import\pages"
)

$ErrorActionPreference = "Stop"

Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Step 4: Cleanup Markdown (Simple)" -ForegroundColor Cyan
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
}

$mdFiles = Get-ChildItem -Path $ImportDir -Recurse -Filter "*.md"

Write-Host "Processing $($mdFiles.Count) files..." -ForegroundColor Yellow
Write-Host ""

foreach ($mdFile in $mdFiles) {
    $stats.FilesProcessed++
    $content = Get-Content -Path $mdFile.FullName -Raw -Encoding UTF8
    $originalContent = $content
    $fileChanged = $false
    
    # Fix 1: Convert literal \n to actual newlines
    if ($content -match '\\n') {
        $content = $content -replace '\\n', "`n"
        $stats.NewlineChars++
        $fileChanged = $true
    }
    
    # Fix 2: Convert MediaWiki headers (== Header ==) to Markdown (# Header)
    # == Header == becomes ## Header
    # === Header === becomes ### Header
    # etc.
    if ($content -match '={2,6}\s+.+?\s+={2,6}') {
        $content = [regex]::Replace($content, '^(\s*)={2,6}\s+(.+?)\s+={2,6}\s*$', {
            param($match)
            $indent = $match.Groups[1].Value
            $headerText = $match.Groups[2].Value
            $equalsCount = ($match.Value -split '=').Count - 1
            $level = [math]::Min($equalsCount, 6)
            $stats.MediaWikiHeaders++
            $script:fileChanged = $true
            return "$indent" + ("#" * $level) + " $headerText"
        }, [System.Text.RegularExpressions.RegexOptions]::Multiline)
        $fileChanged = $true
    }
    
    # Fix 3: Remove MediaWiki directives
    if ($content -match '__TOC__|__NOTOC__') {
        $content = $content -replace '__TOC__|__NOTOC__', ''
        $stats.MediaWikiDirectives++
        $fileChanged = $true
    }
    
    # Fix 4: Convert \* to * for list items
    if ($content -match '\\\*') {
        $content = $content -replace '\\\*', '*'
        $stats.ListItems++
        $fileChanged = $true
    }
    
    # Write back if changed
    if ($fileChanged) {
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
Write-Host "  Newline characters:  $($stats.NewlineChars)" -ForegroundColor White
Write-Host "  MediaWiki directives: $($stats.MediaWikiDirectives)" -ForegroundColor White
Write-Host "  List items:          $($stats.ListItems)" -ForegroundColor White
Write-Host ""

Write-Host "[SUCCESS] Markdown cleanup complete" -ForegroundColor Green
exit 0

