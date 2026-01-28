# 03_rewrite_links.ps1
# Rewrites internal links to match WikiJS import structure

param(
    [string]$ImportDir = ".\content\import\pages",
    [string]$ReportFile = ".\IMPORT_REPORT.md"
)

$ErrorActionPreference = "Stop"

Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Step 3: Rewrite Internal Links" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $ImportDir)) {
    Write-Host "ERROR: Import directory not found: $ImportDir" -ForegroundColor Red
    Write-Host "Run 02_build_import_tree.ps1 first" -ForegroundColor Yellow
    exit 1
}

# Namespace mapping for MediaWiki namespaces
$namespaceIdMap = @{
    "User" = "ns_2"
    "User talk" = "ns_3"
    "User_talk" = "ns_3"
    "Talk" = "ns_1"
    "Template" = "ns_10"
    "Category" = "ns_14"
    "Project" = "ns_4"
    "File" = "ns_6"
    "Image" = "ns_6"
    "MediaWiki" = "ns_8"
}

# Build index of all pages
Write-Host "Building page index..." -ForegroundColor Yellow
$pageIndex = @{}

$mdFiles = Get-ChildItem -Path $ImportDir -Recurse -Filter "*.md"

foreach ($mdFile in $mdFiles) {
    $nsName = $mdFile.Directory.Name
    $slug = [System.IO.Path]::GetFileNameWithoutExtension($mdFile.Name)
    
    # Read frontmatter to get title
    $content = Get-Content -Path $mdFile.FullName -Raw -Encoding UTF8
    $title = $slug -replace '_', ' '
    
    if ($content -match '(?s)^---\s*\r?\n.*?title:\s*["'']?([^"'']+)["'']?') {
        $title = $matches[1]
    }
    
    # Create multiple lookup keys
    $slugWithSpaces = $slug -replace '_', ' '
    $keys = @(
        $title,                                    # Original title
        $title.ToLower(),                          # Lowercase
        $slug,                                     # Slug
        $slugWithSpaces,                           # Slug with spaces
        $slugWithSpaces.ToLower()                  # Slug with spaces, lowercase
    )
    
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

Write-Host "  Indexed $($mdFiles.Count) pages with $($pageIndex.Keys.Count) lookup keys" -ForegroundColor Green
Write-Host ""

# Statistics
$stats = @{
    FilesProcessed = 0
    LinksRewritten = 0
    LinksSkipped = 0
    MissingLinks = @{}
    NamespaceLinks = 0
}

# Process each markdown file
Write-Host "Rewriting links..." -ForegroundColor Yellow

foreach ($mdFile in $mdFiles) {
    $stats.FilesProcessed++
    $content = Get-Content -Path $mdFile.FullName -Raw -Encoding UTF8
    $originalContent = $content
    $fileChanged = $false
    
    # Pattern 1: MediaWiki links [[Title]] or [[Title|Text]]
    $content = [regex]::Replace($content, '\[\[([^\]]+)\]\]', {
        param($match)
        $linkText = $match.Groups[1].Value
        
        # Handle pipe syntax: [[Title|Text]]
        if ($linkText -match '^([^|]+)\|(.+)$') {
            $target = $matches[1].Trim()
            $display = $matches[2].Trim()
        } else {
            $target = $linkText.Trim()
            $display = $target
        }
        
        # Handle anchors: [[Title#Section]]
        $anchor = ""
        if ($target -match '^([^#]+)#(.+)$') {
            $target = $matches[1].Trim()
            $anchor = "#" + ($matches[2].Trim().ToLower() -replace '\s+', '-')
        }
        
        # Check for namespace prefix
        $namespace = $null
        $pageTitle = $target
        
        if ($target -match '^([^:]+):(.+)$') {
            $nsPrefix = $matches[1].Trim()
            $pageTitle = $matches[2].Trim()
            
            if ($namespaceIdMap.ContainsKey($nsPrefix)) {
                $namespace = $namespaceIdMap[$nsPrefix]
                $stats.NamespaceLinks++
            }
        }
        
        # Try to find the page
        $pageTitleUnderscore = $pageTitle -replace '\s+', '_'
        $lookupKeys = @(
            $pageTitle,
            $pageTitle.ToLower(),
            $pageTitleUnderscore,
            $pageTitleUnderscore.ToLower()
        )
        
        $found = $false
        foreach ($key in $lookupKeys) {
            if ($pageIndex.ContainsKey($key)) {
                $candidates = $pageIndex[$key]
                
                # If namespace specified, filter by namespace
                if ($namespace) {
                    $candidates = $candidates | Where-Object { $_.Namespace -eq $namespace }
                }
                
                if ($candidates.Count -gt 0) {
                    $targetPage = $candidates[0]
                    $newLink = "[$display]($($targetPage.Path)$anchor)"
                    $script:stats.LinksRewritten++
                    $fileChanged = $true
                    return $newLink
                }
            }
        }
        
        # Not found - mark as missing
        if (-not $stats.MissingLinks.ContainsKey($target)) {
            $stats.MissingLinks[$target] = 0
        }
        $stats.MissingLinks[$target]++
        $stats.LinksSkipped++
        
        return "[$display](#missing:$target)"
    })
    
    # Pattern 2: HTML wikilink class (from Pandoc conversion)
    $content = [regex]::Replace($content, '<a\s+href="([^"]+)"\s+class="wikilink"[^>]*>([^<]+)</a>', {
        param($match)
        $href = $match.Groups[1].Value
        $text = $match.Groups[2].Value
        
        # Try to resolve the href
        $target = $href -replace '^/wiki/', '' -replace '^/w/index\.php\?title=', '' -replace '&.*$', ''
        # URL decode (simple version - replace %20 with space, etc.)
        $target = $target -replace '%20', ' ' -replace '%2F', '/' -replace '%3A', ':'
        
        $targetUnderscore = $target -replace '\s+', '_'
        $lookupKeys = @(
            $target,
            $target.ToLower(),
            $targetUnderscore,
            $targetUnderscore.ToLower()
        )
        
        foreach ($key in $lookupKeys) {
            if ($pageIndex.ContainsKey($key)) {
                $candidates = $pageIndex[$key]
                if ($candidates.Count -gt 0) {
                    $targetPage = $candidates[0]
                    $newLink = "[$text]($($targetPage.Path))"
                    $script:stats.LinksRewritten++
                    $fileChanged = $true
                    return $newLink
                }
            }
        }
        
        # Not found
        if (-not $stats.MissingLinks.ContainsKey($target)) {
            $stats.MissingLinks[$target] = 0
        }
        $stats.MissingLinks[$target]++
        $stats.LinksSkipped++
        
        return "[$text](#missing:$target)"
    })
    
    # Pattern 3: Relative wiki paths
    $content = [regex]::Replace($content, '\]\(/wiki/([^)]+)\)', {
        param($match)
        $target = $match.Groups[1].Value
        # URL decode (simple version - replace %20 with space, etc.)
        $target = $target -replace '%20', ' ' -replace '%2F', '/' -replace '%3A', ':'
        
        $targetUnderscore = $target -replace '\s+', '_'
        $lookupKeys = @(
            $target,
            $target.ToLower(),
            $targetUnderscore,
            $targetUnderscore.ToLower()
        )
        
        foreach ($key in $lookupKeys) {
            if ($pageIndex.ContainsKey($key)) {
                $candidates = $pageIndex[$key]
                if ($candidates.Count -gt 0) {
                    $targetPage = $candidates[0]
                    $newLink = "]($($targetPage.Path))"
                    $script:stats.LinksRewritten++
                    $fileChanged = $true
                    return $newLink
                }
            }
        }
        
        return $match.Value
    })
    
    # Write back if changed
    if ($fileChanged) {
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
Write-Host "Namespace links:       $($stats.NamespaceLinks)" -ForegroundColor Cyan
Write-Host "Unique missing links:  $($stats.MissingLinks.Count)" -ForegroundColor $(if ($stats.MissingLinks.Count -gt 0) { "Yellow" } else { "Green" })
Write-Host ""

# Calculate resolution rate
$totalLinks = $stats.LinksRewritten + $stats.LinksSkipped
$resolutionRate = 0
if ($totalLinks -gt 0) {
    $resolutionRate = [math]::Round(($stats.LinksRewritten / $totalLinks) * 100, 1)
    Write-Host "Link resolution rate:   $resolutionRate%" -ForegroundColor $(if ($resolutionRate -ge 95) { "Green" } elseif ($resolutionRate -ge 80) { "Yellow" } else { "Red" })
}

# Generate report
Write-Host ""
Write-Host "Generating report: $ReportFile" -ForegroundColor Yellow

$reportContent = @"
# PAWS Wiki Import Report

Generated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

## Link Rewrite Statistics

- **Files processed**: $($stats.FilesProcessed)
- **Links rewritten**: $($stats.LinksRewritten)
- **Links skipped/missing**: $($stats.LinksSkipped)
- **Namespace links**: $($stats.NamespaceLinks)
- **Unique missing targets**: $($stats.MissingLinks.Count)
- **Resolution rate**: $resolutionRate%

## Missing Links (Top 50)

The following link targets were not found in the import tree:

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

if ($resolutionRate -lt 95) {
    Write-Host "WARNING: Link resolution rate is below 95%" -ForegroundColor Yellow
    Write-Host "Review missing links in the report above." -ForegroundColor Yellow
} else {
    Write-Host "[OK] Link resolution rate meets target (>=95%)" -ForegroundColor Green
}

exit 0

