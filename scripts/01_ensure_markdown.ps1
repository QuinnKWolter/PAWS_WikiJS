# 01_ensure_markdown.ps1
# Ensures every .wiki file has a corresponding .md file
# Regenerates from .wiki if .md is missing or too small

param(
    [string]$WikiSrcDir = ".\wiki-src",
    [int]$MinMdSize = 10
)

$ErrorActionPreference = "Stop"

Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Step 1: Ensure Markdown Files Exist" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host ""

# Verify Pandoc is available
Write-Host "Checking for Pandoc..." -ForegroundColor Yellow
try {
    $pandocVersion = pandoc --version 2>&1 | Select-Object -First 1
    Write-Host "  Found: $pandocVersion" -ForegroundColor Green
} catch {
    Write-Host "  ERROR: Pandoc not found!" -ForegroundColor Red
    Write-Host "  Install from: https://pandoc.org/installing.html" -ForegroundColor Yellow
    exit 1
}

if (-not (Test-Path $WikiSrcDir)) {
    Write-Host "ERROR: Source directory not found: $WikiSrcDir" -ForegroundColor Red
    exit 1
}

Write-Host "Scanning $WikiSrcDir for .wiki files..." -ForegroundColor Yellow
Write-Host ""

$stats = @{
    TotalWiki = 0
    ExistingMd = 0
    Regenerated = 0
    Failed = 0
    Skipped = 0
}

# Find all .wiki files
$wikiFiles = Get-ChildItem -Path $WikiSrcDir -Recurse -Filter "*.wiki" | Where-Object { $_.Name -notlike "*.wiki.*" }

$stats.TotalWiki = $wikiFiles.Count
Write-Host "Found $($stats.TotalWiki) .wiki files" -ForegroundColor Cyan
Write-Host ""

# Process each .wiki file
foreach ($wikiFile in $wikiFiles) {
    $mdFile = $wikiFile.FullName -replace '\.wiki$', '.md'
    $relativePath = $wikiFile.FullName.Replace((Resolve-Path $WikiSrcDir).Path + "\", "")
    
    # Check if .md exists and is valid
    $needsRegeneration = $false
    
    if (-not (Test-Path $mdFile)) {
        $needsRegeneration = $true
        Write-Host "  Missing: $relativePath" -ForegroundColor Yellow
    } elseif ((Get-Item $mdFile).Length -lt $MinMdSize) {
        $needsRegeneration = $true
        Write-Host "  Too small: $relativePath ($((Get-Item $mdFile).Length) bytes)" -ForegroundColor Yellow
    } else {
        $stats.ExistingMd++
        $stats.Skipped++
        if ($stats.Skipped % 50 -eq 0) {
            Write-Host "  Processed $($stats.Skipped) files..." -ForegroundColor Gray
        }
        continue
    }
    
    # Regenerate from .wiki
    if ($needsRegeneration) {
        Write-Host "  Regenerating: $relativePath" -ForegroundColor Cyan
        try {
            $result = pandoc -f mediawiki -t gfm $wikiFile.FullName -o $mdFile 2>&1
            if ($LASTEXITCODE -eq 0) {
                $stats.Regenerated++
                Write-Host "    ✓ Generated" -ForegroundColor Green
            } else {
                $stats.Failed++
                Write-Host "    ✗ Failed: $result" -ForegroundColor Red
            }
        } catch {
            $stats.Failed++
            Write-Host "    ✗ Error: $_" -ForegroundColor Red
        }
    }
}

Write-Host ""
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Summary" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Total .wiki files:     $($stats.TotalWiki)" -ForegroundColor White
Write-Host "Existing .md files:   $($stats.ExistingMd)" -ForegroundColor Green
Write-Host "Regenerated:          $($stats.Regenerated)" -ForegroundColor Cyan
Write-Host "Failed:               $($stats.Failed)" -ForegroundColor $(if ($stats.Failed -gt 0) { "Red" } else { "Green" })
Write-Host ""

if ($stats.Failed -gt 0) {
    Write-Host "WARNING: Some files failed to convert. Check errors above." -ForegroundColor Yellow
    exit 1
} else {
    Write-Host "✓ All .wiki files have corresponding .md files" -ForegroundColor Green
    exit 0
}

