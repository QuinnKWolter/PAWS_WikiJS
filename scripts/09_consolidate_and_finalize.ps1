# 09_consolidate_and_finalize.ps1
# Consolidates duplicate directories and finalizes the structure

param(
    [string]$ProjectRoot = "."
)

$ErrorActionPreference = "Stop"

Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Consolidate and Finalize Structure" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host ""

$stats = @{
    DirectoriesRemoved = 0
    FilesMoved = 0
    DuplicatesFound = 0
}

# Check for duplicate/empty directories
Write-Host "Checking for duplicate directories..." -ForegroundColor Yellow

# Check content/pages (should be empty or can be removed)
if (Test-Path ".\content\pages") {
    $pageFiles = Get-ChildItem -Path ".\content\pages" -Recurse -File
    if ($pageFiles.Count -eq 0) {
        Write-Host "  Removing empty content/pages directory" -ForegroundColor Gray
        Remove-Item -Path ".\content\pages" -Recurse -Force -ErrorAction SilentlyContinue
        $stats.DirectoriesRemoved++
    } else {
        Write-Host "  WARNING: content/pages has $($pageFiles.Count) files - not removing" -ForegroundColor Yellow
    }
}

# Check root-level media directory (should be empty or can be removed)
if (Test-Path ".\media") {
    $mediaFiles = Get-ChildItem -Path ".\media" -Recurse -File
    if ($mediaFiles.Count -eq 0) {
        Write-Host "  Removing empty media directory" -ForegroundColor Gray
        Remove-Item -Path ".\media" -Recurse -Force -ErrorAction SilentlyContinue
        $stats.DirectoriesRemoved++
    } else {
        Write-Host "  WARNING: media has $($mediaFiles.Count) files - not removing" -ForegroundColor Yellow
    }
}

# Fix media paths - they should be relative from import/pages to media
Write-Host ""
Write-Host "Fixing media file paths..." -ForegroundColor Yellow

$mdFiles = Get-ChildItem -Path ".\content\import\pages" -Recurse -Filter "*.md"
$mediaFiles = Get-ChildItem -Path ".\content\media" -Recurse -File | 
    Where-Object { $_.Extension -match '\.(jpg|jpeg|png|gif|pdf|svg|webp|bmp|ico)$' }

# Build media index with proper relative paths
$mediaIndex = @{}
foreach ($mediaFile in $mediaFiles) {
    $fileName = $mediaFile.Name
    $fileNameStem = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
    
    # Path relative to content/import/pages (go up two levels, then into media)
    $relativePath = $mediaFile.FullName.Replace((Resolve-Path ".\content").Path + "\", "").Replace("\", "/")
    
    $keys = @($fileName, $fileName.ToLower(), $fileNameStem, $fileNameStem.ToLower())
    foreach ($key in $keys) {
        if (-not $mediaIndex.ContainsKey($key)) {
            $mediaIndex[$key] = @()
        }
        $mediaIndex[$key] += $relativePath
    }
}

$mediaFixed = 0
foreach ($mdFile in $mdFiles) {
    $content = Get-Content -Path $mdFile.FullName -Raw -Encoding UTF8
    if ($null -eq $content) { $content = "" }
    $originalContent = $content
    
    # Fix broken media paths
    $lines = $content -split "`n"
    $fixedLines = @()
    $fileChanged = $false
    
    foreach ($line in $lines) {
        $originalLine = $line
        
        # Fix markdown images ![alt](path)
        while ($line -match '!\[([^\]]*)\]\(([^)]+)\)') {
            $fullMatch = $matches[0]
            $altText = $matches[1]
            $imagePath = $matches[2]
            
            # Clean path
            $cleanPath = $imagePath -replace '.*media[\\/]', '' -replace '.*content[\\/]media[\\/]', ''
            $cleanPath = $cleanPath -replace '\\', '/'
            $fileName = [System.IO.Path]::GetFileName($cleanPath)
            $fileNameStem = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
            
            # Lookup
            $lookupKeys = @($fileName, $fileName.ToLower(), $fileNameStem, $fileNameStem.ToLower())
            $found = $false
            
            foreach ($key in $lookupKeys) {
                if ($mediaIndex.ContainsKey($key)) {
                    $mediaPaths = $mediaIndex[$key]
                    if ($mediaPaths.Count -gt 0) {
                        # Path from content/import/pages/ns_X/file.md to content/media/...
                        # $mediaPaths[0] is already relative to content/, so just go up two levels
                        $newPath = "../../$($mediaPaths[0])"
                        $newLink = "![$altText]($newPath)"
                        
                        # Prevent infinite loop: break if replacement would be no-op
                        if ($newLink -eq $fullMatch) { break }
                        
                        $line = $line -replace [regex]::Escape($fullMatch), $newLink
                        $mediaFixed++
                        $fileChanged = $true
                        $found = $true
                        break
                    }
                }
            }
            
            if (-not $found) {
                break
            }
        }
        
        # Fix HTML img tags
        while ($line -match '<img\s+[^>]*src=["'']([^"'']+)["'']') {
            $fullMatch = $matches[0]
            $imagePath = $matches[1]
            
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
                        # $mediaPaths[0] is already relative to content/, so just go up two levels
                        $newPath = "../../$($mediaPaths[0])"
                        $newImgTag = $fullMatch -replace [regex]::Escape($imagePath), $newPath
                        
                        # Prevent infinite loop: break if replacement would be no-op
                        if ($newImgTag -eq $fullMatch) { break }
                        
                        $line = $line -replace [regex]::Escape($fullMatch), $newImgTag
                        $mediaFixed++
                        $fileChanged = $true
                        $found = $true
                        break
                    }
                }
            }
            
            if (-not $found) {
                break
            }
        }
        
        $fixedLines += $line
    }
    
    if ($fileChanged) {
        $content = $fixedLines -join "`n"
        $content | Out-File -FilePath $mdFile.FullName -Encoding UTF8 -NoNewline
    }
}

Write-Host "  Fixed $mediaFixed media references" -ForegroundColor Green
Write-Host ""

Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Summary" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Directories removed:    $($stats.DirectoriesRemoved)" -ForegroundColor Green
Write-Host "Media references fixed: $mediaFixed" -ForegroundColor Green
Write-Host ""

Write-Host "[SUCCESS] Consolidation complete" -ForegroundColor Green

exit 0

