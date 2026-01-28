# RUN_ALL.ps1
# Master script to run the entire migration pipeline

param(
    [string]$WikiSrcDir = ".\wiki-src",
    [string]$ImportDir = ".\content\import\pages",
    [switch]$SkipStep1,
    [switch]$SkipStep2,
    [switch]$SkipStep3,
    [switch]$SkipStep4,
    [switch]$SkipStep5,
    [switch]$SkipStep6
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host ("=" * 70) -ForegroundColor Magenta
Write-Host "PAWS Wiki Migration Pipeline" -ForegroundColor Magenta
Write-Host ("=" * 70) -ForegroundColor Magenta
Write-Host ""
Write-Host "This script will:" -ForegroundColor Cyan
Write-Host "  1. Ensure all .md files exist (regenerate from .wiki if needed)" -ForegroundColor White
Write-Host "  2. Build import tree with frontmatter" -ForegroundColor White
Write-Host "  3. Rewrite internal links" -ForegroundColor White
Write-Host "  4. Cleanup markdown issues" -ForegroundColor White
Write-Host "  5. Fix all links comprehensively (internal + media)" -ForegroundColor White
Write-Host "  6. Consolidate structure and finalize" -ForegroundColor White
Write-Host ""

# Verify prerequisites
Write-Host "Checking prerequisites..." -ForegroundColor Yellow

# Check Pandoc
try {
    $null = pandoc --version 2>&1
    Write-Host "  ✓ Pandoc found" -ForegroundColor Green
} catch {
    Write-Host "  ✗ Pandoc not found!" -ForegroundColor Red
    Write-Host "    Install from: https://pandoc.org/installing.html" -ForegroundColor Yellow
    exit 1
}

# Check source directory
if (-not (Test-Path $WikiSrcDir)) {
    Write-Host "  ✗ Source directory not found: $WikiSrcDir" -ForegroundColor Red
    exit 1
}
Write-Host "  ✓ Source directory found: $WikiSrcDir" -ForegroundColor Green

# Check/create import directory
if (-not (Test-Path $ImportDir)) {
    New-Item -ItemType Directory -Path $ImportDir -Force | Out-Null
    Write-Host "  ✓ Created import directory: $ImportDir" -ForegroundColor Green
} else {
    Write-Host "  ✓ Import directory exists: $ImportDir" -ForegroundColor Green
}

Write-Host ""
Write-Host "Starting pipeline..." -ForegroundColor Cyan
Write-Host ""

$startTime = Get-Date
$stepResults = @{}

# Step 1: Ensure Markdown
if (-not $SkipStep1) {
    Write-Host ("=" * 70) -ForegroundColor Magenta
    Write-Host "STEP 1: Ensure Markdown Files" -ForegroundColor Magenta
    Write-Host ("=" * 70) -ForegroundColor Magenta
    Write-Host ""
    
    try {
        & ".\scripts\01_ensure_markdown.ps1" -WikiSrcDir $WikiSrcDir
        $stepResults["Step1"] = "Success"
        Write-Host ""
    } catch {
        $stepResults["Step1"] = "Failed: $_"
        Write-Host "ERROR in Step 1: $_" -ForegroundColor Red
        Write-Host "Continuing anyway..." -ForegroundColor Yellow
        Write-Host ""
    }
} else {
    Write-Host "Skipping Step 1 (--SkipStep1)" -ForegroundColor Yellow
    $stepResults["Step1"] = "Skipped"
}

# Step 2: Build Import Tree
if (-not $SkipStep2) {
    Write-Host ("=" * 70) -ForegroundColor Magenta
    Write-Host "STEP 2: Build Import Tree" -ForegroundColor Magenta
    Write-Host ("=" * 70) -ForegroundColor Magenta
    Write-Host ""
    
    try {
        & ".\scripts\02_build_import_tree.ps1" -WikiSrcDir $WikiSrcDir -ImportDir $ImportDir
        $stepResults["Step2"] = "Success"
        Write-Host ""
    } catch {
        $stepResults["Step2"] = "Failed: $_"
        Write-Host "ERROR in Step 2: $_" -ForegroundColor Red
        Write-Host "Continuing anyway..." -ForegroundColor Yellow
        Write-Host ""
    }
} else {
    Write-Host "Skipping Step 2 (--SkipStep2)" -ForegroundColor Yellow
    $stepResults["Step2"] = "Skipped"
}

# Step 3: Rewrite Links
if (-not $SkipStep3) {
    Write-Host ("=" * 70) -ForegroundColor Magenta
    Write-Host "STEP 3: Rewrite Internal Links" -ForegroundColor Magenta
    Write-Host ("=" * 70) -ForegroundColor Magenta
    Write-Host ""
    
    try {
        & ".\scripts\03_rewrite_links.ps1" -ImportDir $ImportDir
        $stepResults["Step3"] = "Success"
        Write-Host ""
    } catch {
        $stepResults["Step3"] = "Failed: $_"
        Write-Host "ERROR in Step 3: $_" -ForegroundColor Red
        Write-Host "Continuing anyway..." -ForegroundColor Yellow
        Write-Host ""
    }
} else {
    Write-Host "Skipping Step 3 (--SkipStep3)" -ForegroundColor Yellow
    $stepResults["Step3"] = "Skipped"
}

# Step 4: Cleanup Markdown
if (-not $SkipStep4) {
    Write-Host ("=" * 70) -ForegroundColor Magenta
    Write-Host "STEP 4: Cleanup Markdown" -ForegroundColor Magenta
    Write-Host ("=" * 70) -ForegroundColor Magenta
    Write-Host ""
    
    try {
        & ".\scripts\04_cleanup_markdown_final.ps1" -ImportDir $ImportDir
        $stepResults["Step4"] = "Success"
        Write-Host ""
    } catch {
        $stepResults["Step4"] = "Failed: $_"
        Write-Host "ERROR in Step 4: $_" -ForegroundColor Red
        Write-Host "Continuing anyway..." -ForegroundColor Yellow
        Write-Host ""
    }
} else {
    Write-Host "Skipping Step 4 (--SkipStep4)" -ForegroundColor Yellow
    $stepResults["Step4"] = "Skipped"
}

# Step 5: Fix All Links Comprehensively
if (-not $SkipStep5) {
    Write-Host ("=" * 70) -ForegroundColor Magenta
    Write-Host "STEP 5: Fix All Links (Internal + Media)" -ForegroundColor Magenta
    Write-Host ("=" * 70) -ForegroundColor Magenta
    Write-Host ""
    
    try {
        & ".\scripts\08_fix_all_links_final.ps1" -ImportDir $ImportDir
        $stepResults["Step5"] = "Success"
        Write-Host ""
    } catch {
        $stepResults["Step5"] = "Failed: $_"
        Write-Host "ERROR in Step 5: $_" -ForegroundColor Red
        Write-Host "Continuing anyway..." -ForegroundColor Yellow
        Write-Host ""
    }
} else {
    Write-Host "Skipping Step 5 (--SkipStep5)" -ForegroundColor Yellow
    $stepResults["Step5"] = "Skipped"
}

# Step 6: Consolidate and Finalize
if (-not $SkipStep6) {
    Write-Host ("=" * 70) -ForegroundColor Magenta
    Write-Host "STEP 6: Consolidate Structure and Finalize" -ForegroundColor Magenta
    Write-Host ("=" * 70) -ForegroundColor Magenta
    Write-Host ""
    
    try {
        & ".\scripts\09_consolidate_and_finalize.ps1"
        $stepResults["Step6"] = "Success"
        Write-Host ""
    } catch {
        $stepResults["Step6"] = "Failed: $_"
        Write-Host "ERROR in Step 6: $_" -ForegroundColor Red
        Write-Host "Continuing anyway..." -ForegroundColor Yellow
        Write-Host ""
    }
} else {
    Write-Host "Skipping Step 6 (--SkipStep6)" -ForegroundColor Yellow
    $stepResults["Step6"] = "Skipped"
}

# Final Summary
$endTime = Get-Date
$duration = $endTime - $startTime

Write-Host ""
Write-Host ("=" * 70) -ForegroundColor Magenta
Write-Host "Pipeline Complete" -ForegroundColor Magenta
Write-Host ("=" * 70) -ForegroundColor Magenta
Write-Host ""
Write-Host "Step Results:" -ForegroundColor Cyan
foreach ($step in $stepResults.Keys | Sort-Object) {
    $status = $stepResults[$step]
    $color = if ($status -eq "Success") { "Green" } elseif ($status -eq "Skipped") { "Yellow" } else { "Red" }
    Write-Host "  $step : $status" -ForegroundColor $color
}

Write-Host ""
Write-Host "Duration: $($duration.TotalMinutes.ToString('F1')) minutes" -ForegroundColor Cyan
Write-Host ""

# Count results
$importFiles = if (Test-Path $ImportDir) {
    (Get-ChildItem -Path $ImportDir -Recurse -Filter "*.md").Count
} else {
    0
}

Write-Host "Import tree contains: $importFiles markdown files" -ForegroundColor Cyan
Write-Host "Location: $ImportDir" -ForegroundColor Cyan
Write-Host ""

if (Test-Path ".\IMPORT_REPORT.md") {
    Write-Host "See IMPORT_REPORT.md for detailed link statistics" -ForegroundColor Yellow
}

Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Review the import tree in: $ImportDir" -ForegroundColor White
Write-Host "  2. Check IMPORT_REPORT.md for missing links" -ForegroundColor White
Write-Host "  3. Import into WikiJS using Git storage or bulk import" -ForegroundColor White
Write-Host ""

exit 0

