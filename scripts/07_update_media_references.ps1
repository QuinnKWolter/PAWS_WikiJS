# 07_update_media_references.ps1
# Updates media file references in markdown files to point to new taxonomic organization

param(
    [string]$ImportDir = ".\content\import\pages",
    [string]$MediaDir = ".\content\media",
    [string]$MappingFile = ".\content\media\media_mapping.json"
)

$ErrorActionPreference = "Stop"

Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Step 7: Update Media References" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $ImportDir)) {
    Write-Host "ERROR: Import directory not found: $ImportDir" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $MappingFile)) {
    Write-Host "ERROR: Media mapping file not found: $MappingFile" -ForegroundColor Red
    Write-Host "Run 05_extract_media_files.ps1 first" -ForegroundColor Yellow
    exit 1
}

# Load media mapping
Write-Host "Loading media mapping..." -ForegroundColor Yellow
$mappingContent = Get-Content -Path $MappingFile -Raw -Encoding UTF8
$mediaMapping = $mappingContent | ConvertFrom-Json

# Build lookup index: original filename -> new path
$fileIndex = @{}
foreach ($file in $mediaMapping.files) {
    $originalName = $file.original_name
    $newPath = $file.new_path
    
    # Create multiple lookup keys
    $keys = @(
        $originalName,
        $originalName.ToLower(),
        [System.IO.Path]::GetFileNameWithoutExtension($originalName),
        [System.IO.Path]::GetFileNameWithoutExtension($originalName).ToLower()
    )
    
    foreach ($key in $keys) {
        if (-not $fileIndex.ContainsKey($key)) {
            $fileIndex[$key] = @()
        }
        $fileIndex[$key] += $newPath
    }
}

Write-Host "  Indexed $($mediaMapping.files.Count) media files" -ForegroundColor Green
Write-Host ""

$stats = @{
    FilesProcessed = 0
    FilesModified = 0
    ReferencesUpdated = 0
    ReferencesNotFound = 0
    Patterns = @{
        MarkdownImages = 0
        HtmlImages = 0
        HtmlLinks = 0
        MediaWikiLinks = 0
    }
}

Write-Host "Scanning markdown files for media references..." -ForegroundColor Yellow

$mdFiles = Get-ChildItem -Path $ImportDir -Recurse -Filter "*.md"

foreach ($mdFile in $mdFiles) {
    $stats.FilesProcessed++
    $content = Get-Content -Path $mdFile.FullName -Raw -Encoding UTF8
    if ($null -eq $content) {
        $content = ""
    }
    $originalContent = $content
    $fileChanged = $false
    
    # Pattern 1: Markdown images ![alt](path/to/file.ext)
    $content = [regex]::Replace($content, '!\[([^\]]*)\]\(([^)]+)\)', {
        param($match)
        $altText = $match.Groups[1].Value
        $imagePath = $match.Groups[2].Value
        
        # Extract filename from path
        $fileName = [System.IO.Path]::GetFileName($imagePath)
        $fileNameStem = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
        
        # Try to find in index
        $found = $false
        $lookupKeys = @($fileName, $fileName.ToLower(), $fileNameStem, $fileNameStem.ToLower())
        
        foreach ($key in $lookupKeys) {
            if ($fileIndex.ContainsKey($key)) {
                $newPaths = $fileIndex[$key]
                if ($newPaths.Count -gt 0) {
                    $newPath = $newPaths[0]
                    # Make path relative to content root
                    $relativePath = "../media/$newPath"
                    $stats.ReferencesUpdated++
                    $stats.Patterns.MarkdownImages++
                    $script:fileChanged = $true
                    return "![$altText]($relativePath)"
                }
            }
        }
        
        # Not found
        $stats.ReferencesNotFound++
        return $match.Value
    })
    
    # Pattern 2: HTML img tags <img src="path/to/file.ext">
    $content = [regex]::Replace($content, '<img\s+[^>]*src=["'']([^"'']+)["'']', {
        param($match)
        $imagePath = $match.Groups[1].Value
        $fileName = [System.IO.Path]::GetFileName($imagePath)
        $fileNameStem = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
        
        $lookupKeys = @($fileName, $fileName.ToLower(), $fileNameStem, $fileNameStem.ToLower())
        
        foreach ($key in $lookupKeys) {
            if ($fileIndex.ContainsKey($key)) {
                $newPaths = $fileIndex[$key]
                if ($newPaths.Count -gt 0) {
                    $newPath = $newPaths[0]
                    $relativePath = "../media/$newPath"
                    $stats.ReferencesUpdated++
                    $stats.Patterns.HtmlImages++
                    $script:fileChanged = $true
                    return $match.Value -replace [regex]::Escape($imagePath), $relativePath
                }
            }
        }
        
        return $match.Value
    })
    
    # Pattern 3: HTML links to files <a href="path/to/file.pdf">
    $content = [regex]::Replace($content, '<a\s+[^>]*href=["'']([^"'']+\.(pdf|doc|docx|zip|tar|gz))["'']', {
        param($match)
        $filePath = $match.Groups[1].Value
        $fileName = [System.IO.Path]::GetFileName($filePath)
        $fileNameStem = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
        
        $lookupKeys = @($fileName, $fileName.ToLower(), $fileNameStem, $fileNameStem.ToLower())
        
        foreach ($key in $lookupKeys) {
            if ($fileIndex.ContainsKey($key)) {
                $newPaths = $fileIndex[$key]
                if ($newPaths.Count -gt 0) {
                    $newPath = $newPaths[0]
                    $relativePath = "../media/$newPath"
                    $stats.ReferencesUpdated++
                    $stats.Patterns.HtmlLinks++
                    $script:fileChanged = $true
                    return $match.Value -replace [regex]::Escape($filePath), $relativePath
                }
            }
        }
        
        return $match.Value
    })
    
    # Pattern 4: MediaWiki file links [[File:Example.jpg]] or [[Image:Example.jpg]]
    $content = [regex]::Replace($content, '\[\[(File|Image):([^\]]+)\]\]', {
        param($match)
        $fileName = $match.Groups[2].Value.Trim()
        $fileNameStem = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
        
        $lookupKeys = @($fileName, $fileName.ToLower(), $fileNameStem, $fileNameStem.ToLower())
        
        foreach ($key in $lookupKeys) {
            if ($fileIndex.ContainsKey($key)) {
                $newPaths = $fileIndex[$key]
                if ($newPaths.Count -gt 0) {
                    $newPath = $newPaths[0]
                    $relativePath = "../media/$newPath"
                    $stats.ReferencesUpdated++
                    $stats.Patterns.MediaWikiLinks++
                    $script:fileChanged = $true
                    return "![$fileName]($relativePath)"
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
Write-Host "References updated:    $($stats.ReferencesUpdated)" -ForegroundColor Green
Write-Host "References not found:  $($stats.ReferencesNotFound)" -ForegroundColor $(if ($stats.ReferencesNotFound -gt 0) { "Yellow" } else { "Green" })
Write-Host ""
Write-Host "Patterns matched:" -ForegroundColor Cyan
Write-Host "  Markdown images:    $($stats.Patterns.MarkdownImages)" -ForegroundColor White
Write-Host "  HTML images:        $($stats.Patterns.HtmlImages)" -ForegroundColor White
Write-Host "  HTML links:         $($stats.Patterns.HtmlLinks)" -ForegroundColor White
Write-Host "  MediaWiki links:    $($stats.Patterns.MediaWikiLinks)" -ForegroundColor White
Write-Host ""

Write-Host "[SUCCESS] Media references updated" -ForegroundColor Green

exit 0

