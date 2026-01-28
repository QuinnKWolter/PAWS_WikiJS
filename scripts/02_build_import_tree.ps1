# 02_build_import_tree.ps1
# Builds the import tree with proper structure and frontmatter

param(
    [string]$WikiSrcDir = ".\wiki-src",
    [string]$ImportDir = ".\content\import\pages"
)

$ErrorActionPreference = "Stop"

Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Step 2: Build Import Tree" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host ""

# Create import directory structure
if (-not (Test-Path $ImportDir)) {
    New-Item -ItemType Directory -Path $ImportDir -Force | Out-Null
    Write-Host "Created import directory: $ImportDir" -ForegroundColor Green
}

if (-not (Test-Path $WikiSrcDir)) {
    Write-Host "ERROR: Source directory not found: $WikiSrcDir" -ForegroundColor Red
    exit 1
}

$stats = @{
    TotalProcessed = 0
    TotalCreated = 0
    TotalSkipped = 0
    Namespaces = @{}
}

# Namespace mapping (for reference)
$namespaceMap = @{
    "ns_0" = "Main"
    "ns_1" = "Talk"
    "ns_2" = "User"
    "ns_3" = "User talk"
    "ns_4" = "Project"
    "ns_6" = "File"
    "ns_8" = "MediaWiki"
    "ns_10" = "Template"
    "ns_14" = "Category"
}

# Find all namespace directories
$namespaceDirs = Get-ChildItem -Path $WikiSrcDir -Directory -Filter "ns_*"

Write-Host "Found $($namespaceDirs.Count) namespaces" -ForegroundColor Cyan
Write-Host ""

foreach ($nsDir in $namespaceDirs) {
    $nsName = $nsDir.Name
    $nsDisplayName = if ($namespaceMap.ContainsKey($nsName)) { $namespaceMap[$nsName] } else { $nsName }
    
    Write-Host "Processing namespace: $nsName ($nsDisplayName)" -ForegroundColor Yellow
    
    # Create namespace directory in import tree
    $nsImportDir = Join-Path $ImportDir $nsName
    if (-not (Test-Path $nsImportDir)) {
        New-Item -ItemType Directory -Path $nsImportDir -Force | Out-Null
    }
    
    $nsStats = @{
        Processed = 0
        Created = 0
        Skipped = 0
    }
    
    # Find all .md files in this namespace
    $mdFiles = Get-ChildItem -Path $nsDir.FullName -Filter "*.md" | Where-Object { $_.Name -notlike "*.md.*" }
    
    foreach ($mdFile in $mdFiles) {
        $nsStats.Processed++
        $stats.TotalProcessed++
        
        # Get filename stem (without extension)
        $filenameStem = [System.IO.Path]::GetFileNameWithoutExtension($mdFile.Name)
        
        # Normalize slug (keep underscores, lowercase for consistency)
        $slug = $filenameStem.ToLower()
        
        # Derive human-readable title from filename
        $title = $filenameStem -replace '_', ' '
        
        # Target file path
        $targetFile = Join-Path $nsImportDir "$slug.md"
        
        # Read source markdown
        $content = Get-Content -Path $mdFile.FullName -Raw -Encoding UTF8
        
        # Check if frontmatter already exists
        $hasFrontmatter = $content -match '^---\s*\r?\n'
        
        if ($hasFrontmatter) {
            # Extract existing frontmatter and content
            $frontmatterMatch = $content -match '(?s)^---\s*\r?\n(.*?)\r?\n---\s*\r?\n(.*)$'
            if ($frontmatterMatch) {
                $existingFrontmatter = $matches[1]
                $bodyContent = $matches[2]
                
                # Update frontmatter
                $frontmatter = @"
---
title: "$title"
source_namespace: "$nsName"
source_filename: "$($mdFile.Name)"
$existingFrontmatter
---
"@
                $newContent = $frontmatter + "`n`n" + $bodyContent
            } else {
                # Malformed frontmatter, replace it
                $newContent = @"
---
title: "$title"
source_namespace: "$nsName"
source_filename: "$($mdFile.Name)"
---

$content
"@
            }
        } else {
            # Add frontmatter
            $newContent = @"
---
title: "$title"
source_namespace: "$nsName"
source_filename: "$($mdFile.Name)"
---

$content
"@
        }
        
        # Write to target
        try {
            $newContent | Out-File -FilePath $targetFile -Encoding UTF8 -NoNewline
            $nsStats.Created++
            $stats.TotalCreated++
            
            if ($nsStats.Created % 20 -eq 0) {
                Write-Host "  Processed $($nsStats.Created) files..." -ForegroundColor Gray
            }
        } catch {
            Write-Host "  ERROR writing $targetFile : $_" -ForegroundColor Red
            $nsStats.Skipped++
            $stats.TotalSkipped++
        }
    }
    
    $stats.Namespaces[$nsName] = $nsStats
    Write-Host "  Namespace $nsName : $($nsStats.Created) files created" -ForegroundColor Green
    Write-Host ""
}

Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Summary" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Total files processed:  $($stats.TotalProcessed)" -ForegroundColor White
Write-Host "Files created:         $($stats.TotalCreated)" -ForegroundColor Green
Write-Host "Files skipped:        $($stats.TotalSkipped)" -ForegroundColor $(if ($stats.TotalSkipped -gt 0) { "Yellow" } else { "Green" })
Write-Host ""

Write-Host "Per-namespace breakdown:" -ForegroundColor Cyan
foreach ($nsName in $stats.Namespaces.Keys | Sort-Object) {
    $nsStats = $stats.Namespaces[$nsName]
    Write-Host "  $nsName : $($nsStats.Created) files" -ForegroundColor White
}

Write-Host ""
Write-Host "[SUCCESS] Import tree created at: $ImportDir" -ForegroundColor Green
exit 0

