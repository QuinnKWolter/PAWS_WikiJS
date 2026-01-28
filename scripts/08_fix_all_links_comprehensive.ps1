# 08_fix_all_links_comprehensive.ps1
# Comprehensive link fixing: internal page links AND media references

param(
    [string]$ImportDir = ".\content\import\pages",
    [string]$MediaDir = ".\content\media"
)

$ErrorActionPreference = "Stop"

Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Comprehensive Link Fixing" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $ImportDir)) {
    Write-Host "ERROR: Import directory not found: $ImportDir" -ForegroundColor Red
    exit 1
}

# Build page index for internal links
Write-Host "Building page index..." -ForegroundColor Yellow
$pageIndex = @{}

$mdFiles = Get-ChildItem -Path $ImportDir -Recurse -Filter "*.md"

foreach ($mdFile in $mdFiles) {
    $nsName = $mdFile.Directory.Name
    $slug = [System.IO.Path]::GetFileNameWithoutExtension($mdFile.Name)
    
    $content = Get-Content -Path $mdFile.FullName -Raw -Encoding UTF8
    if ($null -eq $content) { $content = "" }
    
    $title = $slug -replace '_', ' '
    
    # Extract title from frontmatter if present
    if ($content -match '(?s)^---\s*\r?\n.*?title:\s*["'']?([^"'']+)["'']?') {
        $title = $matches[1]
    }
    
    # Create lookup keys
    $slugWithSpaces = $slug -replace '_', ' '
    $keys = @(
        $title,
        $title.ToLower(),
        $slug,
        $slug.ToLower(),
        $slugWithSpaces,
        $slugWithSpaces.ToLower()
    )
    
    # WikiJS path format (without /import prefix for now, we'll use relative paths)
    $targetPath = "/$nsName/$slug"
    
    foreach ($key in $keys) {
        if (-not $pageIndex.ContainsKey($key)) {
            $pageIndex[$key] = @()
        }
        $pageIndex[$key] += @{
            Path = $targetPath
            Namespace = $nsName
            Slug = $slug
            Title = $title
            FilePath = $mdFile.FullName
        }
    }
}

Write-Host "  Indexed $($mdFiles.Count) pages" -ForegroundColor Green
Write-Host ""

# Build media file index
Write-Host "Building media file index..." -ForegroundColor Yellow
$mediaIndex = @{}

if (Test-Path $MediaDir) {
    $mediaFiles = Get-ChildItem -Path $MediaDir -Recurse -File | 
        Where-Object { $_.Extension -match '\.(jpg|jpeg|png|gif|pdf|svg|webp|bmp|ico|doc|docx|zip|tar|gz)$' }
    
    foreach ($mediaFile in $mediaFiles) {
        $fileName = $mediaFile.Name
        $fileNameStem = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
        
        # Get relative path from media directory
        $relativePath = $mediaFile.FullName.Replace((Resolve-Path $MediaDir).Path + "\", "").Replace("\", "/")
        
        $keys = @(
            $fileName,
            $fileName.ToLower(),
            $fileNameStem,
            $fileNameStem.ToLower()
        )
        
        foreach ($key in $keys) {
            if (-not $mediaIndex.ContainsKey($key)) {
                $mediaIndex[$key] = @()
            }
            $mediaIndex[$key] += $relativePath
        }
    }
}

Write-Host "  Indexed $($mediaFiles.Count) media files" -ForegroundColor Green
Write-Host ""

$stats = @{
    FilesProcessed = 0
    FilesModified = 0
    InternalLinksFixed = 0
    MediaLinksFixed = 0
    BrokenLinks = 0
    MediaNotFound = 0
}

Write-Host "Fixing links in markdown files..." -ForegroundColor Yellow

foreach ($mdFile in $mdFiles) {
    $stats.FilesProcessed++
    $content = Get-Content -Path $mdFile.FullName -Raw -Encoding UTF8
    if ($null -eq $content) { $content = "" }
    $originalContent = $content
    $fileChanged = $false
    
    # Fix 1: Fix broken media paths (like ../media/.\content\media\...)
    if ($content -match '\.\./media.*content') {
        $content = $content -replace '\.\./media[^)]*content[^)]*media[^)]*/', '../media/'
        $content = $content -replace '\.\./media[^)]*\\', '../media/'
        $fileChanged = $true
    }
    
    # Fix 2: HTML wikilink class links to internal pages
    # Process line by line to avoid regex callback issues
    $lines = $content -split "`n"
    $fixedLines = @()
    
    foreach ($line in $lines) {
        # Pattern: <a href="PageName" class="wikilink"> or <a href="PageName#anchor" class="wikilink">
        if ($line -match '<a\s+href="([^"#]+)(?:#([^"]+))?"\s+class="wikilink"[^>]*>([^<]+)</a>') {
            $pageName = $matches[1].Trim()
            $anchor = if ($matches[2]) { "#" + ($matches[2].Trim().ToLower() -replace '\s+', '-') } else { "" }
            $linkText = $matches[3].Trim()
            
            # Try to find the page
            $lookupKeys = @(
                $pageName,
                $pageName.ToLower(),
                $pageName -replace '\s+', '_',
                ($pageName -replace '\s+', '_').ToLower()
            )
            
            $found = $false
            foreach ($key in $lookupKeys) {
                if ($pageIndex.ContainsKey($key)) {
                    $candidates = $pageIndex[$key]
                    if ($candidates.Count -gt 0) {
                        $targetPage = $candidates[0]
                        $newLink = "[$linkText]($($targetPage.Path)$anchor)"
                        $line = $line -replace [regex]::Escape($matches[0]), $newLink
                        $stats.InternalLinksFixed++
                        $fileChanged = $true
                        $found = $true
                        break
                    }
                }
            }
            
            if (-not $found) {
                # Not found - convert to markdown link anyway
                $pageSlug = $pageName -replace '\s+', '-' -replace '[^\w-]', ''
                $newLink = "[$linkText](/ns_0/$pageSlug$anchor)"
                $line = $line -replace [regex]::Escape($matches[0]), $newLink
                $stats.BrokenLinks++
                $fileChanged = $true
            }
        }
        
        $fixedLines += $line
    }
    
    $content = $fixedLines -join "`n"
    
    # Fix 3: MediaWiki-style internal links [[PageName]] or [[PageName|Text]]
    # Process with line-by-line matching
    $lines = $content -split "`n"
    $fixedLines = @()
    
    foreach ($line in $lines) {
        if ($line -match '\[\[([^\]]+)\]\]') {
            $linkText = $matches[1]
            
            # Handle pipe syntax
            if ($linkText -match '^([^|]+)\|(.+)$') {
                $target = $matches[1].Trim()
                $display = $matches[2].Trim()
            } else {
                $target = $linkText.Trim()
                $display = $target
            }
            
            # Skip if it's a category or namespace we don't want
            if ($target -notmatch '^(Category|Template|User|File|Image):') {
                # Handle anchors
                $anchor = ""
                if ($target -match '^([^#]+)#(.+)$') {
                    $target = $matches[1].Trim()
                    $anchor = "#" + ($matches[2].Trim().ToLower() -replace '\s+', '-')
                }
                
                # Lookup page
                $lookupKeys = @(
                    $target,
                    $target.ToLower(),
                    $target -replace '\s+', '_',
                    ($target -replace '\s+', '_').ToLower()
                )
                
                $found = $false
                foreach ($key in $lookupKeys) {
                    if ($pageIndex.ContainsKey($key)) {
                        $candidates = $pageIndex[$key]
                        if ($candidates.Count -gt 0) {
                            $targetPage = $candidates[0]
                            $newLink = "[$display]($($targetPage.Path)$anchor)"
                            $line = $line -replace [regex]::Escape("[[$linkText]]"), $newLink
                            $stats.InternalLinksFixed++
                            $fileChanged = $true
                            $found = $true
                            break
                        }
                    }
                }
                
                if (-not $found) {
                    # Not found
                    $pageSlug = $target -replace '\s+', '-' -replace '[^\w-]', ''
                    $newLink = "[$display](/ns_0/$pageSlug$anchor)"
                    $line = $line -replace [regex]::Escape("[[$linkText]]"), $newLink
                    $stats.BrokenLinks++
                    $fileChanged = $true
                }
            }
        }
        
        $fixedLines += $line
    }
    
    $content = $fixedLines -join "`n"
    
    # Fix 3b: MediaWiki-style internal links (alternative approach for remaining)
    $content = [regex]::Replace($content, '\[\[([^\]]+)\]\]', {
        param($match)
        $linkText = $match.Groups[1].Value
        
        # Handle pipe syntax
        if ($linkText -match '^([^|]+)\|(.+)$') {
            $target = $matches[1].Trim()
            $display = $matches[2].Trim()
        } else {
            $target = $linkText.Trim()
            $display = $target
        }
        
        # Skip if it's a category or namespace we don't want
        if ($target -match '^(Category|Template|User|File|Image):') {
            return $match.Value  # Keep as-is for now
        }
        
        # Handle anchors
        $anchor = ""
        if ($target -match '^([^#]+)#(.+)$') {
            $target = $matches[1].Trim()
            $anchor = "#" + ($matches[2].Trim().ToLower() -replace '\s+', '-')
        }
        
        # Lookup page
        $lookupKeys = @(
            $target,
            $target.ToLower(),
            $target -replace '\s+', '_',
            ($target -replace '\s+', '_').ToLower()
        )
        
        foreach ($key in $lookupKeys) {
            if ($pageIndex.ContainsKey($key)) {
                $candidates = $pageIndex[$key]
                if ($candidates.Count -gt 0) {
                    $targetPage = $candidates[0]
                    $newLink = "[$display]($($targetPage.Path)$anchor)"
                    $stats.InternalLinksFixed++
                    $script:fileChanged = $true
                    return $newLink
                }
            }
        }
        
        # Not found
        $pageSlug = $target -replace '\s+', '-' -replace '[^\w-]', ''
        $newLink = "[$display](/ns_0/$pageSlug$anchor)"
        $stats.BrokenLinks++
        return $newLink
    })
    
    # Fix 4: Update media file references
    # Pattern: ![alt](path) or <img src="path">
    $content = [regex]::Replace($content, '!\[([^\]]*)\]\(([^)]+)\)', {
        param($match)
        $altText = $match.Groups[1].Value
        $imagePath = $match.Groups[2].Value
        
        # Clean up broken paths
        $imagePath = $imagePath -replace '.*media[\\/]', '' -replace '.*content[\\/]media[\\/]', ''
        $imagePath = $imagePath -replace '\\', '/'
        
        # Extract filename
        $fileName = [System.IO.Path]::GetFileName($imagePath)
        $fileNameStem = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
        
        # Lookup in media index
        $lookupKeys = @($fileName, $fileName.ToLower(), $fileNameStem, $fileNameStem.ToLower())
        
        foreach ($key in $lookupKeys) {
            if ($mediaIndex.ContainsKey($key)) {
                $mediaPaths = $mediaIndex[$key]
                if ($mediaPaths.Count -gt 0) {
                    $newPath = "../media/$($mediaPaths[0])"
                    $stats.MediaLinksFixed++
                    $script:fileChanged = $true
                    return "![$altText]($newPath)"
                }
            }
        }
        
        # Not found
        $stats.MediaNotFound++
        return $match.Value
    })
    
    # Fix 5: HTML img tags
    $content = [regex]::Replace($content, '<img\s+[^>]*src=["'']([^"'']+)["'']', {
        param($match)
        $imagePath = $match.Groups[1].Value
        
        # Clean up broken paths
        $imagePath = $imagePath -replace '.*media[\\/]', '' -replace '.*content[\\/]media[\\/]', ''
        $imagePath = $imagePath -replace '\\', '/'
        
        $fileName = [System.IO.Path]::GetFileName($imagePath)
        $fileNameStem = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
        
        $lookupKeys = @($fileName, $fileName.ToLower(), $fileNameStem, $fileNameStem.ToLower())
        
        foreach ($key in $lookupKeys) {
            if ($mediaIndex.ContainsKey($key)) {
                $mediaPaths = $mediaIndex[$key]
                if ($mediaPaths.Count -gt 0) {
                    $newPath = "../media/$($mediaPaths[0])"
                    $stats.MediaLinksFixed++
                    $script:fileChanged = $true
                    return $match.Value -replace [regex]::Escape($match.Groups[1].Value), $newPath
                }
            }
        }
        
        return $match.Value
    })
    
    # Write back if changed
    if ($fileChanged) {
        $content | Out-File -FilePath $mdFile.FullName -Encoding UTF8 -NoNewline
        $stats.FilesModified++
        
        if ($stats.FilesModified % 50 -eq 0) {
            Write-Host "  Updated $($stats.FilesModified) files..." -ForegroundColor Gray
        }
    }
}

Write-Host ""
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Summary" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Files processed:       $($stats.FilesProcessed)" -ForegroundColor White
Write-Host "Files modified:        $($stats.FilesModified)" -ForegroundColor Green
Write-Host "Internal links fixed:  $($stats.InternalLinksFixed)" -ForegroundColor Green
Write-Host "Media links fixed:     $($stats.MediaLinksFixed)" -ForegroundColor Green
Write-Host "Broken links:          $($stats.BrokenLinks)" -ForegroundColor $(if ($stats.BrokenLinks -gt 0) { "Yellow" } else { "Green" })
Write-Host "Media not found:       $($stats.MediaNotFound)" -ForegroundColor $(if ($stats.MediaNotFound -gt 0) { "Yellow" } else { "Green" })
Write-Host ""

Write-Host "[SUCCESS] Comprehensive link fixing complete" -ForegroundColor Green

exit 0

