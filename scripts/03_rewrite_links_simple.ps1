# Simplified version that processes files one at a time
# This avoids PowerShell regex callback issues

param(
    [string]$ImportDir = ".\content\import\pages",
    [string]$ReportFile = ".\IMPORT_REPORT.md"
)

$ErrorActionPreference = "Stop"

Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Step 3: Rewrite Internal Links (Simplified)" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $ImportDir)) {
    Write-Host "ERROR: Import directory not found: $ImportDir" -ForegroundColor Red
    exit 1
}

# Build page index (simplified)
Write-Host "Building page index..." -ForegroundColor Yellow
$pageIndex = @{}

$mdFiles = Get-ChildItem -Path $ImportDir -Recurse -Filter "*.md"

foreach ($mdFile in $mdFiles) {
    $nsName = $mdFile.Directory.Name
    $slug = [System.IO.Path]::GetFileNameWithoutExtension($mdFile.Name)
    
    $content = Get-Content -Path $mdFile.FullName -Raw -Encoding UTF8
    $title = $slug -replace '_', ' '
    
    if ($content -match '(?s)^---\s*\r?\n.*?title:\s*["'']?([^"'']+)["'']?') {
        $title = $matches[1]
    }
    
    $slugWithSpaces = $slug -replace '_', ' '
    $keys = @($title, $title.ToLower(), $slug, $slugWithSpaces, $slugWithSpaces.ToLower())
    
    $targetPath = "/import/$nsName/$slug"
    
    foreach ($key in $keys) {
        if (-not $pageIndex.ContainsKey($key)) {
            $pageIndex[$key] = @()
        }
        $pageIndex[$key] += @{
            Path = $targetPath
            Namespace = $nsName
            Slug = $slug
            Title = $title
        }
    }
}

Write-Host "  Indexed $($mdFiles.Count) pages" -ForegroundColor Green
Write-Host ""

# Process files
$stats = @{
    FilesProcessed = 0
    LinksRewritten = 0
    LinksSkipped = 0
    MissingLinks = @{}
}

Write-Host "Rewriting links..." -ForegroundColor Yellow

foreach ($mdFile in $mdFiles) {
    $stats.FilesProcessed++
    $content = Get-Content -Path $mdFile.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Simple pattern matching and replacement
    # Pattern: [[Title]] or [[Title|Text]]
    $pattern = '\[\[([^\]]+)\]\]'
    $matches = [regex]::Matches($content, $pattern)
    
    for ($i = $matches.Count - 1; $i -ge 0; $i--) {
        $match = $matches[$i]
        $linkText = $match.Groups[1].Value
        
        # Parse link
        if ($linkText -match '^([^|]+)\|(.+)$') {
            $target = $matches[1].Trim()
            $display = $matches[2].Trim()
        } else {
            $target = $linkText.Trim()
            $display = $target
        }
        
        # Handle anchor
        $anchor = ""
        if ($target -match '^([^#]+)#(.+)$') {
            $target = $matches[1].Trim()
            $anchor = "#" + ($matches[2].Trim().ToLower() -replace '\s+', '-')
        }
        
        # Check namespace
        $namespace = $null
        $pageTitle = $target
        if ($target -match '^([^:]+):(.+)$') {
            $nsPrefix = $matches[1].Trim()
            $pageTitle = $matches[2].Trim()
            $namespaceIdMap = @{
                "User" = "ns_2"
                "Category" = "ns_14"
                "Template" = "ns_10"
            }
            if ($namespaceIdMap.ContainsKey($nsPrefix)) {
                $namespace = $namespaceIdMap[$nsPrefix]
            }
        }
        
        # Lookup
        $lookupKeys = @($pageTitle, $pageTitle.ToLower(), ($pageTitle -replace '\s+', '_'), ($pageTitle -replace '\s+', '_').ToLower())
        $found = $false
        
        foreach ($key in $lookupKeys) {
            if ($pageIndex.ContainsKey($key)) {
                $candidates = $pageIndex[$key]
                if ($namespace) {
                    $candidates = $candidates | Where-Object { $_.Namespace -eq $namespace }
                }
                if ($candidates.Count -gt 0) {
                    $targetPage = $candidates[0]
                    $newLink = "[$display]($($targetPage.Path)$anchor)"
                    $content = $content.Substring(0, $match.Index) + $newLink + $content.Substring($match.Index + $match.Length)
                    $stats.LinksRewritten++
                    $found = $true
                    break
                }
            }
        }
        
        if (-not $found) {
            if (-not $stats.MissingLinks.ContainsKey($target)) {
                $stats.MissingLinks[$target] = 0
            }
            $stats.MissingLinks[$target]++
            $stats.LinksSkipped++
            $newLink = "[$display](#missing:$target)"
            $content = $content.Substring(0, $match.Index) + $newLink + $content.Substring($match.Index + $match.Length)
        }
    }
    
    # Write back if changed
    if ($content -ne $originalContent) {
        $content | Out-File -FilePath $mdFile.FullName -Encoding UTF8 -NoNewline
    }
    
    if ($stats.FilesProcessed % 50 -eq 0) {
        Write-Host "  Processed $($stats.FilesProcessed) files..." -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Summary" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Files processed:       $($stats.FilesProcessed)" -ForegroundColor White
Write-Host "Links rewritten:       $($stats.LinksRewritten)" -ForegroundColor Green
Write-Host "Links skipped/missing: $($stats.LinksSkipped)" -ForegroundColor $(if ($stats.LinksSkipped -gt 0) { "Yellow" } else { "Green" })
Write-Host "Unique missing links:  $($stats.MissingLinks.Count)" -ForegroundColor $(if ($stats.MissingLinks.Count -gt 0) { "Yellow" } else { "Green" })
Write-Host ""

$totalLinks = $stats.LinksRewritten + $stats.LinksSkipped
$resolutionRate = 0
if ($totalLinks -gt 0) {
    $resolutionRate = [math]::Round(($stats.LinksRewritten / $totalLinks) * 100, 1)
    Write-Host "Link resolution rate:   $resolutionRate%" -ForegroundColor $(if ($resolutionRate -ge 95) { "Green" } elseif ($resolutionRate -ge 80) { "Yellow" } else { "Red" })
}

# Generate report
$reportContent = @"
# PAWS Wiki Import Report

Generated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

## Link Rewrite Statistics

- **Files processed**: $($stats.FilesProcessed)
- **Links rewritten**: $($stats.LinksRewritten)
- **Links skipped/missing**: $($stats.LinksSkipped)
- **Unique missing targets**: $($stats.MissingLinks.Count)
- **Resolution rate**: $resolutionRate%

## Missing Links (Top 50)

"@

$topMissing = $stats.MissingLinks.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 50
if ($topMissing.Count -gt 0) {
    foreach ($missing in $topMissing) {
        $reportContent += "`n- **$($missing.Key)** (referenced $($missing.Value) times)"
    }
} else {
    $reportContent += "`n*No missing links found!*"
}

$reportContent | Out-File -FilePath $ReportFile -Encoding UTF8
Write-Host "[OK] Report saved to: $ReportFile" -ForegroundColor Green
Write-Host ""

exit 0

