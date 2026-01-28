# 08_fix_all_links_final.ps1
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
    
    # WikiJS path format
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
    
    # Process line by line for better control
    $lines = $content -split "`n"
    $fixedLines = @()
    
    foreach ($line in $lines) {
        $originalLine = $line
        
        # Fix 2: HTML wikilink class links <a href="PageName" class="wikilink">
        while ($line -match '<a\s+href="([^"#]+)(?:#([^"]+))?"\s+class="wikilink"[^>]*>([^<]+)</a>') {
            $fullMatch = $matches[0]
            $pageName = $matches[1].Trim()
            $anchor = if ($matches[2]) { "#" + ($matches[2].Trim().ToLower() -replace '\s+', '-') } else { "" }
            $linkText = $matches[3].Trim()
            
            # Try to find the page
            $pageNameUnderscore = $pageName -replace '\s+', '_'
            $lookupKeys = @($pageName, $pageName.ToLower(), $pageNameUnderscore, $pageNameUnderscore.ToLower())
            $found = $false
            
            foreach ($key in $lookupKeys) {
                if ($pageIndex.ContainsKey($key)) {
                    $candidates = $pageIndex[$key]
                    if ($candidates.Count -gt 0) {
                        $targetPage = $candidates[0]
                        $newLink = "[$linkText]($($targetPage.Path)$anchor)"
                        $line = $line -replace [regex]::Escape($fullMatch), $newLink
                        $stats.InternalLinksFixed++
                        $fileChanged = $true
                        $found = $true
                        break
                    }
                }
            }
            
            if (-not $found) {
                # Not found - convert to markdown link
                $pageSlug = $pageName -replace '\s+', '-' -replace '[^\w-]', ''
                $newLink = "[$linkText](/ns_0/$pageSlug$anchor)"
                $line = $line -replace [regex]::Escape($fullMatch), $newLink
                $stats.BrokenLinks++
                $fileChanged = $true
            }
        }
        
        # Fix 3: MediaWiki-style internal links [[PageName]] or [[PageName|Text]]
        while ($line -match '\[\[([^\]]+)\]\]') {
            $fullMatch = $matches[0]
            $linkText = $matches[1]
            
            # Handle pipe syntax
            if ($linkText -match '^([^|]+)\|(.+)$') {
                $target = $matches[1].Trim()
                $display = $matches[2].Trim()
            } else {
                $target = $linkText.Trim()
                $display = $target
            }
            
            # Skip categories and namespaces we don't want
            if ($target -notmatch '^(Category|Template|User|File|Image):') {
                # Handle anchors
                $anchor = ""
                if ($target -match '^([^#]+)#(.+)$') {
                    $target = $matches[1].Trim()
                    $anchor = "#" + ($matches[2].Trim().ToLower() -replace '\s+', '-')
                }
                
                # Lookup page
                $targetUnderscore = $target -replace '\s+', '_'
                $lookupKeys = @($target, $target.ToLower(), $targetUnderscore, $targetUnderscore.ToLower())
                $found = $false
                
                foreach ($key in $lookupKeys) {
                    if ($pageIndex.ContainsKey($key)) {
                        $candidates = $pageIndex[$key]
                        if ($candidates.Count -gt 0) {
                            $targetPage = $candidates[0]
                            $newLink = "[$display]($($targetPage.Path)$anchor)"
                            $line = $line -replace [regex]::Escape($fullMatch), $newLink
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
                    $line = $line -replace [regex]::Escape($fullMatch), $newLink
                    $stats.BrokenLinks++
                    $fileChanged = $true
                }
            } else {
                # Category or namespace - remove the link
                $line = $line -replace [regex]::Escape($fullMatch), ""
                $fileChanged = $true
            }
        }
        
        # Fix 4: Update media file references in markdown images ![alt](path)
        while ($line -match '!\[([^\]]*)\]\(([^)]+)\)') {
            $fullMatch = $matches[0]
            $altText = $matches[1].Value
            $imagePath = $matches[2].Value
            
            # Clean up broken paths
            $cleanPath = $imagePath -replace '.*media[\\/]', '' -replace '.*content[\\/]media[\\/]', ''
            $cleanPath = $cleanPath -replace '\\', '/'
            
            # Extract filename
            $fileName = [System.IO.Path]::GetFileName($cleanPath)
            $fileNameStem = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
            
            # Lookup in media index
            $lookupKeys = @($fileName, $fileName.ToLower(), $fileNameStem, $fileNameStem.ToLower())
            $found = $false
            
            foreach ($key in $lookupKeys) {
                if ($mediaIndex.ContainsKey($key)) {
                    $mediaPaths = $mediaIndex[$key]
                    if ($mediaPaths.Count -gt 0) {
                        # $mediaPaths[0] is relative to MediaDir (content/media), so path from import/pages is ../media/...
                        $newPath = "../media/$($mediaPaths[0])"
                        $newLink = "![$altText]($newPath)"
                        
                        # Prevent infinite loop: break if replacement would be no-op
                        if ($newLink -eq $fullMatch) { break }
                        
                        $line = $line -replace [regex]::Escape($fullMatch), $newLink
                        $stats.MediaLinksFixed++
                        $fileChanged = $true
                        $found = $true
                        break
                    }
                }
            }
            
            if (-not $found) {
                $stats.MediaNotFound++
                break  # Don't loop infinitely
            }
        }
        
        # Fix 5: HTML img tags <img src="path">
        while ($line -match '<img\s+[^>]*src=["'']([^"'']+)["'']') {
            $fullMatch = $matches[0]
            $imagePath = $matches[1].Value
            
            # Clean up broken paths
            $cleanPath = $imagePath -replace '.*media[\\/]', '' -replace '.*content[\\/]media[\\/]', ''
            $cleanPath = $cleanPath -replace '\\', '/'
            
            $fileName = [System.IO.Path]::GetFileName($cleanPath)
            $fileNameStem = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
            
            $lookupKeys = @($fileName, $fileName.ToLower(), $fileNameStem, $fileNameStem.ToLower())
            $found = $false
            
            foreach ($key in $lookupKeys) {
                if ($mediaIndex.ContainsKey($key)) {
                    $mediaPaths = $mediaIndex[$key]
                    if ($mediaPaths.Count -gt 0) {
                        # $mediaPaths[0] is relative to MediaDir (content/media), so path from import/pages is ../media/...
                        $newPath = "../media/$($mediaPaths[0])"
                        $newImgTag = $fullMatch -replace [regex]::Escape($imagePath), $newPath
                        
                        # Prevent infinite loop: break if replacement would be no-op
                        if ($newImgTag -eq $fullMatch) { break }
                        
                        $line = $line -replace [regex]::Escape($fullMatch), $newImgTag
                        $stats.MediaLinksFixed++
                        $fileChanged = $true
                        $found = $true
                        break
                    }
                }
            }
            
            if (-not $found) {
                break  # Don't loop infinitely
            }
        }
        
        $fixedLines += $line
    }
    
    if ($fileChanged) {
        $content = $fixedLines -join "`n"
    }
    
    # Write back if changed
    if ($fileChanged -or $content -ne $originalContent) {
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

