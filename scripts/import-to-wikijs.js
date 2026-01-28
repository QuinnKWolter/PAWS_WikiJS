/**
 * Import Markdown files into WikiJS
 * 
 * This script uses the WikiJS API to bulk import pages from Markdown files.
 * 
 * Usage:
 *   node import-to-wikijs.js <api-key> <content-dir> [options]
 * 
 * Options:
 *   --dry-run    : Show what would be imported without actually importing
 *   --verbose    : Show detailed output
 *   --batch-size : Number of files to process in each batch (default: 10)
 * 
 * Prerequisites:
 *   1. WikiJS must be running and accessible
 *   2. You need an API key with write permissions
 *   3. Markdown files should be in the content directory
 * 
 * To get an API key:
 *   1. Log into WikiJS as admin
 *   2. Go to Administration → API
 *   3. Create a new API key with write permissions
 */

const fs = require('fs');
const path = require('path');
const https = require('https');
const http = require('http');

// Configuration
const DEFAULT_WIKIJS_URL = process.env.WIKIJS_URL || 'http://localhost:3000';
const DEFAULT_BATCH_SIZE = 10;

// Parse command line arguments
const args = process.argv.slice(2);
const apiKey = args[0];
const contentDir = args[1] || 'content/pages';
const options = {
  dryRun: args.includes('--dry-run'),
  verbose: args.includes('--verbose'),
  batchSize: parseInt(args.find(arg => arg.startsWith('--batch-size='))?.split('=')[1]) || DEFAULT_BATCH_SIZE
};

if (!apiKey) {
  console.error('Error: API key is required');
  console.error('Usage: node import-to-wikijs.js <api-key> <content-dir> [options]');
  console.error('');
  console.error('Options:');
  console.error('  --dry-run      Show what would be imported without importing');
  console.error('  --verbose      Show detailed output');
  console.error('  --batch-size=N Number of files per batch (default: 10)');
  process.exit(1);
}

// Helper function to make API requests
function makeRequest(url, method = 'GET', data = null) {
  return new Promise((resolve, reject) => {
    const urlObj = new URL(url);
    const isHttps = urlObj.protocol === 'https:';
    const client = isHttps ? https : http;
    
    const options = {
      hostname: urlObj.hostname,
      port: urlObj.port || (isHttps ? 443 : 80),
      path: urlObj.pathname + urlObj.search,
      method: method,
      headers: {
        'Authorization': `Bearer ${apiKey}`,
        'Content-Type': 'application/json'
      }
    };
    
    if (data) {
      const jsonData = JSON.stringify(data);
      options.headers['Content-Length'] = Buffer.byteLength(jsonData);
    }
    
    const req = client.request(options, (res) => {
      let body = '';
      res.on('data', (chunk) => { body += chunk; });
      res.on('end', () => {
        try {
          const parsed = body ? JSON.parse(body) : {};
          if (res.statusCode >= 200 && res.statusCode < 300) {
            resolve(parsed);
          } else {
            reject(new Error(`API Error ${res.statusCode}: ${parsed.message || body}`));
          }
        } catch (e) {
          reject(new Error(`Parse Error: ${body}`));
        }
      });
    });
    
    req.on('error', reject);
    
    if (data) {
      req.write(JSON.stringify(data));
    }
    
    req.end();
  });
}

// Read markdown file and extract frontmatter
function parseMarkdownFile(filePath) {
  const content = fs.readFileSync(filePath, 'utf-8');
  const filename = path.basename(filePath, '.md');
  
  // Check for frontmatter
  const frontmatterRegex = /^---\s*\n([\s\S]*?)\n---\s*\n([\s\S]*)$/;
  const match = content.match(frontmatterRegex);
  
  let metadata = {};
  let body = content;
  
  if (match) {
    // Parse YAML frontmatter (simple parser)
    const frontmatter = match[1];
    body = match[2];
    
    frontmatter.split('\n').forEach(line => {
      const colonIndex = line.indexOf(':');
      if (colonIndex > 0) {
        const key = line.substring(0, colonIndex).trim();
        const value = line.substring(colonIndex + 1).trim().replace(/^["']|["']$/g, '');
        metadata[key] = value;
      }
    });
  }
  
  return {
    title: metadata.title || filename.replace(/_/g, ' '),
    content: body,
    tags: metadata.tags ? metadata.tags.split(',').map(t => t.trim()) : [],
    description: metadata.description || '',
    path: metadata.path || filename.toLowerCase().replace(/\s+/g, '-')
  };
}

// Import a single page
async function importPage(filePath, stats) {
  try {
    const pageData = parseMarkdownFile(filePath);
    
    if (options.verbose) {
      console.log(`  Processing: ${pageData.title} (${pageData.path})`);
    }
    
    if (options.dryRun) {
      console.log(`  [DRY RUN] Would import: ${pageData.title}`);
      stats.skipped++;
      return;
    }
    
    // Check if page already exists
    try {
      const existing = await makeRequest(
        `${DEFAULT_WIKIJS_URL}/api/pages/${encodeURIComponent(pageData.path)}`
      );
      
      if (existing) {
        console.log(`  Page already exists: ${pageData.title}, skipping...`);
        stats.skipped++;
        return;
      }
    } catch (e) {
      // Page doesn't exist, continue with creation
    }
    
    // Create the page
    const createData = {
      title: pageData.title,
      path: pageData.path,
      content: pageData.content,
      description: pageData.description,
      tags: pageData.tags,
      isPublished: true,
      isPrivate: false
    };
    
    await makeRequest(
      `${DEFAULT_WIKIJS_URL}/api/pages`,
      'POST',
      createData
    );
    
    stats.imported++;
    if (options.verbose) {
      console.log(`  ✓ Imported: ${pageData.title}`);
    }
    
  } catch (error) {
    console.error(`  ✗ Error importing ${filePath}:`, error.message);
    stats.failed++;
  }
}

// Main import function
async function main() {
  console.log('WikiJS Markdown Import Script');
  console.log('==============================');
  console.log(`WikiJS URL: ${DEFAULT_WIKIJS_URL}`);
  console.log(`Content Directory: ${contentDir}`);
  console.log(`Batch Size: ${options.batchSize}`);
  console.log(`Dry Run: ${options.dryRun ? 'Yes' : 'No'}`);
  console.log('');
  
  if (!fs.existsSync(contentDir)) {
    console.error(`Error: Content directory does not exist: ${contentDir}`);
    process.exit(1);
  }
  
  // Get all markdown files
  const files = fs.readdirSync(contentDir)
    .filter(file => file.endsWith('.md'))
    .map(file => path.join(contentDir, file));
  
  console.log(`Found ${files.length} Markdown files`);
  console.log('');
  
  if (files.length === 0) {
    console.log('No files to import.');
    return;
  }
  
  const stats = {
    total: files.length,
    imported: 0,
    skipped: 0,
    failed: 0
  };
  
  // Process files in batches
  for (let i = 0; i < files.length; i += options.batchSize) {
    const batch = files.slice(i, i + options.batchSize);
    const batchNum = Math.floor(i / options.batchSize) + 1;
    const totalBatches = Math.ceil(files.length / options.batchSize);
    
    console.log(`Processing batch ${batchNum}/${totalBatches} (${batch.length} files)...`);
    
    // Process batch sequentially to avoid overwhelming the API
    for (const file of batch) {
      await importPage(file, stats);
      // Small delay to avoid rate limiting
      await new Promise(resolve => setTimeout(resolve, 100));
    }
    
    console.log(`Batch ${batchNum} complete. Progress: ${stats.imported + stats.skipped + stats.failed}/${stats.total}`);
    console.log('');
  }
  
  // Summary
  console.log('Import Summary');
  console.log('==============');
  console.log(`Total files: ${stats.total}`);
  console.log(`Imported: ${stats.imported}`);
  console.log(`Skipped: ${stats.skipped}`);
  console.log(`Failed: ${stats.failed}`);
  
  if (options.dryRun) {
    console.log('');
    console.log('This was a dry run. No pages were actually imported.');
    console.log('Run without --dry-run to perform the actual import.');
  }
}

// Run the import
main().catch(error => {
  console.error('Fatal error:', error);
  process.exit(1);
});

