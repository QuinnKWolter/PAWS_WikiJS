# 05_extract_media_files.ps1
# Extracts and organizes media files from MediaWiki MD5-based directory structure

param(
    [string]$MediaWikiImagesDir = ".\paws-wiki\www\html\w\images",
    [string]$OutputDir = ".\content\media",
    [switch]$OrganizeByType
)

$ErrorActionPreference = "Stop"

Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Step 5: Extract and Organize Media Files" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $MediaWikiImagesDir)) {
    Write-Host "ERROR: MediaWiki images directory not found: $MediaWikiImagesDir" -ForegroundColor Red
    exit 1
}

# Create output directory structure
$imageTypes = @{
    'images' = @('.jpg', '.jpeg', '.png', '.gif', '.svg', '.webp', '.bmp', '.ico')
    'documents' = @('.pdf', '.doc', '.docx', '.txt', '.rtf')
    'archives' = @('.zip', '.tar', '.gz', '.rar', '.7z')
    'other' = @()
}

if ($OrganizeByType) {
    foreach ($type in $imageTypes.Keys) {
        $typeDir = Join-Path $OutputDir $type
        if (-not (Test-Path $typeDir)) {
            New-Item -ItemType Directory -Path $typeDir -Force | Out-Null
        }
    }
} else {
    # Simple structure: images and documents
    $imagesDir = Join-Path $OutputDir "images"
    $documentsDir = Join-Path $OutputDir "documents"
    if (-not (Test-Path $imagesDir)) {
        New-Item -ItemType Directory -Path $imagesDir -Force | Out-Null
    }
    if (-not (Test-Path $documentsDir)) {
        New-Item -ItemType Directory -Path $documentsDir -Force | Out-Null
    }
}

$stats = @{
    FilesFound = 0
    FilesCopied = 0
    FilesSkipped = 0
    Duplicates = 0
    Errors = 0
    ByType = @{
        'images' = 0
        'documents' = 0
        'archives' = 0
        'other' = 0
    }
}

# Track files by name to detect duplicates
$fileIndex = @{}

Write-Host "Scanning MediaWiki images directory..." -ForegroundColor Yellow
Write-Host "Source: $MediaWikiImagesDir" -ForegroundColor Gray
Write-Host "Output: $OutputDir" -ForegroundColor Gray
Write-Host ""

# Get all files (excluding lockdir and archive if needed)
$allFiles = Get-ChildItem -Path $MediaWikiImagesDir -Recurse -File | 
    Where-Object { 
        $_.Directory.Name -ne 'lockdir' -and 
        $_.Extension -match '\.(jpg|jpeg|png|gif|pdf|svg|webp|bmp|ico|doc|docx|txt|rtf|zip|tar|gz|rar|7z)$' 
    }

$stats.FilesFound = $allFiles.Count
Write-Host "Found $($stats.FilesFound) media files" -ForegroundColor Cyan
Write-Host ""

Write-Host "Copying and organizing files..." -ForegroundColor Yellow

foreach ($file in $allFiles) {
    $fileName = $file.Name
    $fileExt = $file.Extension.ToLower()
    
    # Determine file type
    $fileType = "other"
    foreach ($type in $imageTypes.Keys) {
        if ($imageTypes[$type] -contains $fileExt) {
            $fileType = $type
            break
        }
    }
    
    # For simple organization, map to images/documents
    if (-not $OrganizeByType) {
        if ($fileType -eq 'images') {
            $targetDir = $imagesDir
        } elseif ($fileType -eq 'documents' -or $fileType -eq 'archives') {
            $targetDir = $documentsDir
        } else {
            $targetDir = $imagesDir  # Default to images
        }
    } else {
        $targetDir = Join-Path $OutputDir $fileType
    }
    
    # Handle duplicate filenames
    $targetPath = Join-Path $targetDir $fileName
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
    $counter = 1
    
    while (Test-Path $targetPath) {
        # Check if it's the same file (by size and hash)
        $existingFile = Get-Item $targetPath
        if ($existingFile.Length -eq $file.Length) {
            # Same size - might be duplicate, skip
            $stats.FilesSkipped++
            $stats.Duplicates++
            Write-Host "  Skipped duplicate: $fileName" -ForegroundColor Gray
            break
        } else {
            # Different file, same name - add counter
            $newName = "$baseName($counter)$fileExt"
            $targetPath = Join-Path $targetDir $newName
            $counter++
        }
    }
    
    if (-not (Test-Path $targetPath)) {
        try {
            Copy-Item -Path $file.FullName -Destination $targetPath -Force
            $stats.FilesCopied++
            $stats.ByType[$fileType]++
            
            # Track in index
            if (-not $fileIndex.ContainsKey($fileName)) {
                $fileIndex[$fileName] = @()
            }
            $fileIndex[$fileName] += @{
                OriginalPath = $file.FullName
                NewPath = $targetPath
                Type = $fileType
            }
            
            if ($stats.FilesCopied % 50 -eq 0) {
                Write-Host "  Copied $($stats.FilesCopied) files..." -ForegroundColor Gray
            }
        } catch {
            Write-Host "  ERROR copying $fileName : $_" -ForegroundColor Red
            $stats.Errors++
        }
    }
}

Write-Host ""
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Summary" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Files found:           $($stats.FilesFound)" -ForegroundColor White
Write-Host "Files copied:          $($stats.FilesCopied)" -ForegroundColor Green
Write-Host "Files skipped:         $($stats.FilesSkipped)" -ForegroundColor Yellow
Write-Host "Duplicates detected:   $($stats.Duplicates)" -ForegroundColor Yellow
Write-Host "Errors:                $($stats.Errors)" -ForegroundColor $(if ($stats.Errors -gt 0) { "Red" } else { "Green" })
Write-Host ""
Write-Host "Files by type:" -ForegroundColor Cyan
foreach ($type in $stats.ByType.Keys | Sort-Object) {
    if ($stats.ByType[$type] -gt 0) {
        Write-Host "  $type : $($stats.ByType[$type])" -ForegroundColor White
    }
}
Write-Host ""

# Generate file mapping report
$reportFile = Join-Path $OutputDir "media_mapping.json"
$mapping = @{
    generated = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    total_files = $stats.FilesCopied
    organization = if ($OrganizeByType) { "by_type" } else { "simple" }
    files = @()
}

foreach ($fileName in $fileIndex.Keys) {
    foreach ($entry in $fileIndex[$fileName]) {
        $mapping.files += @{
            original_name = $fileName
            original_path = $entry.OriginalPath.Replace((Resolve-Path $MediaWikiImagesDir).Path + "\", "")
            new_path = $entry.NewPath.Replace((Resolve-Path $OutputDir).Path + "\", "")
            type = $entry.Type
        }
    }
}

$mapping | ConvertTo-Json -Depth 10 | Out-File -FilePath $reportFile -Encoding UTF8
Write-Host "File mapping saved to: $reportFile" -ForegroundColor Green
Write-Host ""
Write-Host "[SUCCESS] Media extraction complete" -ForegroundColor Green
Write-Host "Output directory: $OutputDir" -ForegroundColor Cyan

exit 0

