# 06_organize_media_taxonomic.ps1
# Organizes media files into tidy taxonomic folders by file type and purpose

param(
    [string]$MediaDir = ".\content\media",
    [string]$ImagesDir = ".\content\media\images",
    [string]$DocumentsDir = ".\content\media\documents"
)

$ErrorActionPreference = "Stop"

Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Step 6: Organize Media Files Taxonomically" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $MediaDir)) {
    Write-Host "ERROR: Media directory not found: $MediaDir" -ForegroundColor Red
    exit 1
}

# Define taxonomic organization structure
$taxonomy = @{
    'images' = @{
        'photos' = @('photo', 'image', 'img', 'picture', 'pic')
        'screenshots' = @('screenshot', 'screen', 'capture', 'snapshot')
        'diagrams' = @('diagram', 'chart', 'graph', 'flowchart', 'architecture')
        'logos' = @('logo', 'brand', 'icon')
        'presentations' = @('slide', 'presentation', 'ppt')
        'other' = @()
    }
    'documents' = @{
        'pdfs' = @('.pdf')
        'manuals' = @('manual', 'guide', 'tutorial', 'documentation', 'doc')
        'papers' = @('paper', 'publication', 'article', 'research')
        'archives' = @('.zip', '.tar', '.gz', '.rar', '.7z')
        'other' = @()
    }
}

$stats = @{
    FilesProcessed = 0
    FilesMoved = 0
    Categories = @{}
}

# Create taxonomic directory structure
Write-Host "Creating taxonomic directory structure..." -ForegroundColor Yellow

foreach ($mediaType in $taxonomy.Keys) {
    $baseDir = if ($mediaType -eq 'images') { $ImagesDir } else { $DocumentsDir }
    
    if (-not (Test-Path $baseDir)) {
        Write-Host "WARNING: Base directory not found: $baseDir" -ForegroundColor Yellow
        continue
    }
    
    foreach ($category in $taxonomy[$mediaType].Keys) {
        $categoryDir = Join-Path $baseDir $category
        if (-not (Test-Path $categoryDir)) {
            New-Item -ItemType Directory -Path $categoryDir -Force | Out-Null
        }
        $stats.Categories[$category] = 0
    }
}

Write-Host "Organizing images..." -ForegroundColor Yellow

# Organize images
if (Test-Path $ImagesDir) {
    $imageFiles = Get-ChildItem -Path $ImagesDir -File | Where-Object { $_.Directory.Name -eq 'images' }
    
    foreach ($file in $imageFiles) {
        $stats.FilesProcessed++
        $fileName = $file.Name.ToLower()
        $filePath = $file.FullName
        $category = "other"
        
        # Determine category based on filename
        foreach ($cat in $taxonomy['images'].Keys) {
            if ($cat -eq 'other') { continue }
            
            $keywords = $taxonomy['images'][$cat]
            foreach ($keyword in $keywords) {
                if ($fileName -match $keyword) {
                    $category = $cat
                    break
                }
            }
            if ($category -ne "other") { break }
        }
        
        $targetDir = Join-Path $ImagesDir $category
        $targetPath = Join-Path $targetDir $file.Name
        
        if ($filePath -ne $targetPath) {
            try {
                Move-Item -Path $filePath -Destination $targetPath -Force
                $stats.FilesMoved++
                $stats.Categories[$category]++
            } catch {
                Write-Host "  ERROR moving $($file.Name): $_" -ForegroundColor Red
            }
        } else {
            $stats.Categories[$category]++
        }
        
        if ($stats.FilesProcessed % 50 -eq 0) {
            Write-Host "  Processed $($stats.FilesProcessed) files..." -ForegroundColor Gray
        }
    }
}

Write-Host "Organizing documents..." -ForegroundColor Yellow

# Organize documents
if (Test-Path $DocumentsDir) {
    $docFiles = Get-ChildItem -Path $DocumentsDir -File | Where-Object { $_.Directory.Name -eq 'documents' }
    
    foreach ($file in $docFiles) {
        $stats.FilesProcessed++
        $fileName = $file.Name.ToLower()
        $fileExt = $file.Extension.ToLower()
        $filePath = $file.FullName
        $category = "other"
        
        # Check extension first
        if ($fileExt -eq '.pdf') {
            $category = "pdfs"
        } elseif ($fileExt -match '\.(zip|tar|gz|rar|7z)$') {
            $category = "archives"
        } else {
            # Check filename keywords
            foreach ($cat in $taxonomy['documents'].Keys) {
                if ($cat -eq 'other' -or $cat -eq 'pdfs' -or $cat -eq 'archives') { continue }
                
                $keywords = $taxonomy['documents'][$cat]
                foreach ($keyword in $keywords) {
                    if ($fileName -match $keyword) {
                        $category = $cat
                        break
                    }
                }
                if ($category -ne "other") { break }
            }
        }
        
        $targetDir = Join-Path $DocumentsDir $category
        $targetPath = Join-Path $targetDir $file.Name
        
        if ($filePath -ne $targetPath) {
            try {
                Move-Item -Path $filePath -Destination $targetPath -Force
                $stats.FilesMoved++
                $stats.Categories[$category]++
            } catch {
                Write-Host "  ERROR moving $($file.Name): $_" -ForegroundColor Red
            }
        } else {
            $stats.Categories[$category]++
        }
    }
}

Write-Host ""
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Summary" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Files processed:       $($stats.FilesProcessed)" -ForegroundColor White
Write-Host "Files moved:          $($stats.FilesMoved)" -ForegroundColor Green
Write-Host ""
Write-Host "Organization by category:" -ForegroundColor Cyan
foreach ($category in $stats.Categories.Keys | Sort-Object) {
    if ($stats.Categories[$category] -gt 0) {
        Write-Host "  $category : $($stats.Categories[$category])" -ForegroundColor White
    }
}
Write-Host ""

Write-Host "[SUCCESS] Taxonomic organization complete" -ForegroundColor Green
Write-Host "Media directory: $MediaDir" -ForegroundColor Cyan

exit 0

