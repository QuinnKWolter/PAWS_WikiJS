#!/usr/bin/env python3
"""
Fix internal links in converted Markdown files.

This script:
1. Converts MediaWiki-style links to Markdown format
2. Fixes broken internal links
3. Updates file paths to match WikiJS structure
4. Handles namespaces and categories

Usage:
    python fix-links.py <content-dir> [options]

Options:
    --dry-run    : Show what would be changed without making changes
    --verbose    : Show detailed output
    --report     : Generate a report of broken links
"""

import os
import re
import sys
import argparse
from pathlib import Path
from collections import defaultdict

# MediaWiki link patterns
MW_LINK_PATTERN = re.compile(r'\[\[([^\]]+)\]\]')
MW_EXTERNAL_LINK = re.compile(r'\[([^\s]+)\s+([^\]]+)\]')
MW_CATEGORY = re.compile(r'\[\[Category:([^\]]+)\]\]')

def sanitize_filename(title):
    """Convert a page title to a filename-safe string."""
    # Remove special characters, convert spaces to hyphens
    safe = re.sub(r'[^\w\s-]', '', title)
    safe = re.sub(r'[-\s]+', '-', safe)
    return safe.lower().strip('-')

def find_markdown_files(content_dir):
    """Find all Markdown files in the content directory."""
    md_files = []
    for root, dirs, files in os.walk(content_dir):
        for file in files:
            if file.endswith('.md'):
                md_files.append(os.path.join(root, file))
    return md_files

def get_page_titles(content_dir):
    """Build a mapping of page titles to filenames."""
    title_map = {}
    filename_map = {}
    
    for md_file in find_markdown_files(content_dir):
        filename = os.path.basename(md_file)
        title = filename.replace('.md', '').replace('_', ' ').replace('-', ' ')
        
        # Read file to get actual title if available
        try:
            with open(md_file, 'r', 'r', encoding='utf-8') as f:
                content = f.read()
                # Check for frontmatter title
                frontmatter_match = re.search(r'^---\s*\ntitle:\s*["\']?([^"\']+)["\']?', content, re.MULTILINE)
                if frontmatter_match:
                    title = frontmatter_match.group(1)
                # Or check for first H1
                else:
                    h1_match = re.search(r'^#\s+(.+)$', content, re.MULTILINE)
                    if h1_match:
                        title = h1_match.group(1).strip()
        except Exception as e:
            pass
        
        title_map[title.lower()] = md_file
        title_map[title] = md_file
        filename_map[filename] = md_file
    
    return title_map, filename_map

def fix_mediawiki_link(match, title_map, filename_map, stats):
    """Convert a MediaWiki link to Markdown format."""
    link_text = match.group(1)
    
    # Handle pipe syntax: [[Page|Display Text]]
    if '|' in link_text:
        page_title, display_text = link_text.split('|', 1)
    else:
        page_title = link_text
        display_text = page_title
    
    # Handle anchors: [[Page#Section]]
    if '#' in page_title:
        page_title, anchor = page_title.split('#', 1)
        anchor = '#' + anchor.lower().replace(' ', '-')
    else:
        anchor = ''
    
    # Check if it's a category
    if page_title.startswith('Category:'):
        category = page_title.replace('Category:', '')
        stats['categories'] += 1
        return f'[Category: {category}](category:{category.lower()})'
    
    # Check if it's a file/image
    if page_title.startswith('File:') or page_title.startswith('Image:'):
        filename = page_title.split(':', 1)[1]
        stats['files'] += 1
        return f'![{display_text}]({sanitize_filename(filename)})'
    
    # Try to find the page
    page_lower = page_title.lower()
    if page_lower in title_map:
        target_file = title_map[page_lower]
        target_path = os.path.basename(target_file).replace('.md', '')
        stats['fixed'] += 1
        return f'[{display_text}]({target_path}{anchor})'
    else:
        # Page not found - mark as broken
        stats['broken'] += 1
        return f'[{display_text}]({sanitize_filename(page_title)}{anchor}) <!-- Broken link: {page_title} -->'

def fix_links_in_file(filepath, title_map, filename_map, options, stats):
    """Fix links in a single Markdown file."""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        broken_links = []
        
        # Fix MediaWiki links
        def replace_link(match):
            result = fix_mediawiki_link(match, title_map, filename_map, stats)
            if '<!-- Broken link:' in result:
                broken_links.append(result)
            return result
        
        content = MW_LINK_PATTERN.sub(replace_link, content)
        
        # Remove category links (they're handled differently in WikiJS)
        content = MW_CATEGORY.sub(r'', content)
        
        # Write back if changed
        if content != original_content:
            if not options.dry_run:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(content)
                stats['files_modified'] += 1
            else:
                stats['files_modified'] += 1
            
            if options.verbose:
                print(f"  Fixed links in: {os.path.basename(filepath)}")
                if broken_links:
                    for link in broken_links:
                        print(f"    Broken: {link}")
        
        return broken_links
        
    except Exception as e:
        print(f"Error processing {filepath}: {e}", file=sys.stderr)
        stats['errors'] += 1
        return []

def main():
    parser = argparse.ArgumentParser(description='Fix internal links in converted Markdown files')
    parser.add_argument('content_dir', help='Directory containing Markdown files')
    parser.add_argument('--dry-run', action='store_true', help='Show what would be changed')
    parser.add_argument('--verbose', action='store_true', help='Show detailed output')
    parser.add_argument('--report', action='store_true', help='Generate broken links report')
    
    args = parser.parse_args()
    
    if not os.path.isdir(args.content_dir):
        print(f"Error: Directory not found: {args.content_dir}", file=sys.stderr)
        sys.exit(1)
    
    print("Link Fixer for WikiJS Migration")
    print("=" * 40)
    print(f"Content directory: {args.content_dir}")
    print(f"Dry run: {args.dry_run}")
    print()
    
    # Build page title mapping
    print("Building page index...")
    title_map, filename_map = get_page_titles(args.content_dir)
    print(f"Found {len(title_map)} pages")
    print()
    
    # Statistics
    stats = {
        'fixed': 0,
        'broken': 0,
        'categories': 0,
        'files': 0,
        'files_modified': 0,
        'errors': 0
    }
    
    all_broken_links = []
    
    # Process all Markdown files
    md_files = find_markdown_files(args.content_dir)
    print(f"Processing {len(md_files)} files...")
    print()
    
    for md_file in md_files:
        broken = fix_links_in_file(md_file, title_map, filename_map, args, stats)
        all_broken_links.extend(broken)
    
    # Summary
    print()
    print("Summary")
    print("=" * 40)
    print(f"Files processed: {len(md_files)}")
    print(f"Files modified: {stats['files_modified']}")
    print(f"Links fixed: {stats['fixed']}")
    print(f"Broken links: {stats['broken']}")
    print(f"Categories: {stats['categories']}")
    print(f"Files/images: {stats['files']}")
    print(f"Errors: {stats['errors']}")
    
    if args.report and all_broken_links:
        report_file = 'broken-links-report.txt'
        with open(report_file, 'w', encoding='utf-8') as f:
            f.write("Broken Links Report\n")
            f.write("=" * 40 + "\n\n")
            for link in all_broken_links:
                f.write(link + "\n")
        print(f"\nBroken links report saved to: {report_file}")
    
    if args.dry_run:
        print("\nThis was a dry run. No files were modified.")
        print("Run without --dry-run to apply changes.")

if __name__ == '__main__':
    main()

