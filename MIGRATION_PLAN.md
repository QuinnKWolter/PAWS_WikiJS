# PAWS Wiki Migration Plan: MediaWiki → WikiJS

## Overview
This document outlines the complete migration strategy for converting the University of Pittsburgh PAWS Lab Wiki from MediaWiki to WikiJS, including content conversion, theming, and deployment.

---

## Phase 1: Planning & Inventory

### 1.1 Content Audit
- [ ] **Export MediaWiki statistics**
  - Total number of pages/articles
  - Number of templates
  - Number of categories
  - Number of media files (images, PDFs, etc.)
  - Number of users (if migrating accounts)
  - Namespace structure

- [ ] **Identify content types**
  - Standard articles
  - Templates (note which are used frequently)
  - Special pages (redirects, disambiguation)
  - Categories and their hierarchy
  - File uploads and their usage

- [ ] **Document customizations**
  - Custom CSS/JavaScript
  - Extensions in use
  - Custom namespaces
  - Special formatting requirements

### 1.2 Technical Requirements
- [ ] **Infrastructure decisions**
  - Hosting: Docker, VM, or cloud service
  - Database: PostgreSQL (recommended) or MySQL
  - Storage: Local filesystem or cloud storage (S3, etc.)
  - Domain and SSL certificate
  - Backup strategy

- [ ] **Authentication strategy**
  - Local accounts vs. University SSO (LDAP/SAML)
  - User role mapping (admin, editor, reader)
  - Permission structure

---

## Phase 2: Content Export & Conversion

### 2.1 Export from MediaWiki
```bash
# Using MediaWiki's dumpBackup.php script
php maintenance/dumpBackup.php --full --output=mediawiki-dump.xml

# Or use Special:Export for specific pages/namespaces
# Export all pages: Special:Export (select "Include all pages")
```

- [ ] Export complete XML dump of all pages
- [ ] Export page history (if preserving revisions)
- [ ] Download all media files from `/images` or upload directory
- [ ] Export user list (if migrating accounts)
- [ ] Document current URL structure for redirect mapping

### 2.2 Convert to Markdown

#### Using Pandoc
```bash
# Basic conversion
pandoc -f mediawiki -t markdown input.mw -o output.md

# Batch conversion script (see scripts/convert-mediawiki.sh)
```

- [ ] **Install Pandoc** (if not already installed)
- [ ] **Create conversion script** to:
  - Extract pages from XML dump
  - Convert wikitext to Markdown
  - Handle templates (convert to includes or pre-render)
  - Fix internal links (MediaWiki → Markdown format)
  - Preserve categories as tags/metadata
  - Handle special syntax (tables, code blocks, etc.)

- [ ] **Template handling strategy**
  - Option A: Pre-render templates into content
  - Option B: Convert to Markdown includes (if WikiJS supports)
  - Option C: Create custom shortcodes/plugins

- [ ] **Link conversion**
  - Convert `[[Page Name]]` → `[Page Name](page-name.md)`
  - Handle namespaces: `[[Category:Name]]` → tags
  - Fix broken links (redlinks) - decide: remove or mark as TODO

- [ ] **Media file handling**
  - Extract all media references
  - Update paths to match WikiJS structure
  - Ensure file extensions are preserved
  - Handle duplicate filenames

### 2.3 Content Organization
- [ ] **Directory structure** (mirrors WikiJS expectations)
  ```
  content/
  ├── pages/
  │   ├── main/
  │   ├── templates/
  │   └── categories/
  ├── media/
  │   ├── images/
  │   └── attachments/
  └── metadata/
      ├── redirects.json
      └── categories.json
  ```

- [ ] **Metadata extraction**
  - Page titles → filenames (sanitize)
  - Categories → tags
  - Creation dates → frontmatter
  - Authors → frontmatter (if preserving)

---

## Phase 3: WikiJS Setup

### 3.1 Installation
- [ ] **Prerequisites**
  - Node.js (v18+ recommended)
  - PostgreSQL 12+ or MySQL 8+
  - Docker & Docker Compose (if using containerized setup)

- [ ] **Install WikiJS**
  - Using Docker Compose (recommended - see `docker-compose.yml`)
  - Or manual installation
  - Configure database connection
  - Set up initial admin account

- [ ] **Configuration** (`config.yml` or environment variables)
  - Site name: "Pitt PAWS Wiki"
  - Domain/URL
  - Database credentials
  - Storage paths
  - Authentication providers

### 3.2 Storage Setup
- [ ] **Media storage**
  - Configure upload directory
  - Set file size limits
  - Configure backup location
  - Test upload functionality

- [ ] **Content storage**
  - Decide: Database vs. Git-backed (if using Git sync)
  - Set up version control (if applicable)

---

## Phase 4: Theming & Branding

### 4.1 University of Pittsburgh Branding
- [ ] **Colors** (from official Pitt brand guidelines)
  - Primary: Pitt Royal Blue (#003594)
  - Accent: Pitt Gold (#FFB81C)
  - Secondary: New Sky (#DBEEFF), Medium Blue (#00205B)
  - Implement in CSS variables

- [ ] **Typography**
  - Headers: Alternate Gothic ATF Bold
  - Body: Roboto Regular
  - Subheads: Roboto Bold
  - Accent: Instrument Serif Regular
  - Fallbacks: System fonts

- [ ] **Logo & Assets**
  - Obtain official Pitt logo (shield + signature)
  - Place in theme assets
  - Configure in WikiJS settings
  - Set favicon

- [ ] **Layout**
  - Header with logo and navigation
  - Footer with university information
  - Responsive design (mobile-friendly)
  - Maximum content width: ~1320px (Pitt standard)

### 4.2 Theme Implementation
- [ ] **Custom CSS** (see `theme/custom.css`)
  - Override default WikiJS styles
  - Apply Pitt color scheme
  - Customize navigation, buttons, links
  - Ensure WCAG AA contrast compliance

- [ ] **Theme files**
  - Custom header/footer partials (if supported)
  - Logo placement
  - Navigation styling

- [ ] **Testing**
  - Verify theme loads correctly
  - Test on multiple browsers
  - Test responsive design
  - Check accessibility (screen readers, contrast)

---

## Phase 5: Content Import

### 5.1 Import Preparation
- [ ] **Validate converted Markdown**
  - Spot-check 10-20 random pages
  - Verify formatting is correct
  - Check for broken syntax
  - Ensure links are valid

- [ ] **Media file preparation**
  - All files in correct directory structure
  - Filenames sanitized
  - Paths updated in Markdown files

- [ ] **Import script** (see `scripts/import-to-wikijs.js`)
  - Use WikiJS API or CLI
  - Batch import pages
  - Set categories/tags
  - Handle errors gracefully
  - Log import progress

### 5.2 Import Execution
- [ ] **Test import** (small subset)
  - Import 10-20 pages first
  - Verify formatting, links, media
  - Fix any issues found
  - Adjust import script if needed

- [ ] **Full import**
  - Run import script for all pages
  - Monitor for errors
  - Verify page count matches
  - Check media files are accessible

- [ ] **Post-import tasks**
  - Set up redirects (old URLs → new URLs)
  - Configure categories/tags
  - Set page permissions
  - Verify search indexing

---

## Phase 6: Testing & Quality Assurance

### 6.1 Functional Testing
- [ ] **Navigation**
  - All links work
  - Categories/tags display correctly
  - Search functionality works
  - Table of contents generates

- [ ] **Content**
  - Formatting is correct (headings, lists, tables, code)
  - Images display correctly
  - Media files are accessible
  - Special characters render properly

- [ ] **User Experience**
  - Page load times acceptable
  - Mobile responsiveness
  - Accessibility (keyboard navigation, screen readers)
  - Browser compatibility (Chrome, Firefox, Safari, Edge)

### 6.2 Content Validation
- [ ] **Spot checks**
  - Random sample of 50+ pages
  - Compare with original MediaWiki version
  - Verify all critical pages migrated correctly

- [ ] **Link validation**
  - Check for broken internal links
  - Verify external links still work
  - Fix or document broken links

- [ ] **Media validation**
  - All images display
  - PDFs and other attachments accessible
  - File sizes reasonable

---

## Phase 7: Deployment & Go-Live

### 7.1 Pre-Launch
- [ ] **Staging environment**
  - Deploy to staging server
  - Share with stakeholders for review
  - Collect feedback
  - Make final adjustments

- [ ] **Documentation**
  - User guide for editors
  - Admin documentation
  - Migration notes (what changed, what's new)

- [ ] **Backup strategy**
  - Automated backups configured
  - Test restore procedure
  - Document backup schedule

### 7.2 Launch
- [ ] **Final sync**
  - Export any new content from MediaWiki
  - Import final updates to WikiJS
  - Verify everything is current

- [ ] **DNS & SSL**
  - Point domain to new server
  - SSL certificate installed and working
  - Test HTTPS access

- [ ] **Redirects**
  - Set up URL redirects from old wiki (if needed)
  - Update bookmarks/documentation
  - Notify users of new URL

- [ ] **User communication**
  - Announce migration
  - Provide training/resources
  - Set up support channel

### 7.3 Post-Launch
- [ ] **Monitoring**
  - Monitor error logs
  - Track user feedback
  - Monitor performance

- [ ] **Archive old wiki**
  - Keep MediaWiki instance read-only for reference
  - Or export final dump and archive
  - Document archive location

---

## Tools & Resources

### Required Software
- **Pandoc**: https://pandoc.org/ (for MediaWiki → Markdown conversion)
- **WikiJS**: https://js.wiki/ (target platform)
- **PostgreSQL/MySQL**: Database backend
- **Docker**: For containerized deployment (optional but recommended)

### Useful Scripts
- `scripts/convert-mediawiki.sh` - Batch conversion script
- `scripts/import-to-wikijs.js` - WikiJS import script
- `scripts/fix-links.py` - Link validation and fixing

### Documentation
- WikiJS Documentation: https://docs.requarks.io/
- Pandoc User's Guide: https://pandoc.org/MANUAL.html
- University of Pittsburgh Brand Guidelines: https://www.brand.pitt.edu/

---

## Timeline Estimate

| Phase | Estimated Time | Notes |
|-------|---------------|-------|
| Planning & Inventory | 1-2 weeks | Depends on wiki size |
| Export & Conversion | 2-4 weeks | Automated scripts help |
| WikiJS Setup | 1 week | Straightforward with Docker |
| Theming | 1-2 weeks | Iterative refinement |
| Import | 1-2 weeks | Depends on content volume |
| Testing | 2-3 weeks | Thorough QA important |
| Deployment | 1 week | Final prep and launch |
| **Total** | **9-15 weeks** | Varies with complexity |

---

## Success Criteria

- [ ] All content successfully migrated (100% of pages)
- [ ] All media files accessible
- [ ] Theme matches University of Pittsburgh branding
- [ ] All links functional (internal and external)
- [ ] Search functionality working
- [ ] Site accessible and responsive
- [ ] User permissions configured correctly
- [ ] Backups automated and tested
- [ ] Documentation complete
- [ ] Stakeholder approval received

---

## Notes & Considerations

- **Templates**: MediaWiki templates may need manual conversion or custom handling
- **History**: Decide if page revision history is important to preserve
- **Users**: User accounts typically don't migrate; users will need to create new accounts
- **Extensions**: MediaWiki extensions won't work; find WikiJS equivalents or alternatives
- **URLs**: Old URLs may break; redirects or URL mapping may be necessary
- **Search**: WikiJS search may behave differently; test thoroughly

---

*Last Updated: [Date]*
*Migration Lead: [Name]*

