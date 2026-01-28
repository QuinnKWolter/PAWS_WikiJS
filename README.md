# PAWS WikiJS

A modernized port of the University of Pittsburgh PAWS Lab Wiki from MediaWiki to WikiJS, featuring University of Pittsburgh branding and a complete migration toolkit.

## Overview

This project provides a complete setup for migrating the PAWS Wiki from MediaWiki to WikiJS, including:
- Docker-based WikiJS installation
- University of Pittsburgh branded theme
- Conversion scripts for MediaWiki → Markdown
- Import scripts for bulk content migration
- Comprehensive migration documentation

## Project Structure

```
PAWS_WikiJS/
├── docker-compose.yml          # Docker Compose configuration
├── .env.example                # Environment variables template
├── MIGRATION_PLAN.md           # Detailed migration plan
├── theme/                      # Custom Pitt-themed CSS
│   ├── custom.css              # Main stylesheet
│   └── README.md               # Theme documentation
├── scripts/                    # Migration scripts
│   ├── convert-mediawiki.sh    # Convert MediaWiki XML to Markdown (Linux/Mac)
│   ├── convert-mediawiki.ps1   # Convert MediaWiki XML to Markdown (Windows)
│   ├── fix-links.py            # Fix internal links in Markdown files
│   ├── import-to-wikijs.js     # Import Markdown files to WikiJS
│   └── README.md               # Scripts documentation
├── content/                    # Converted content (gitignored)
│   ├── pages/                  # Markdown files
│   └── media/                  # Media files (images, PDFs, etc.)
└── data/                       # WikiJS data (gitignored)
    ├── storage/                # WikiJS storage
    └── logs/                   # Application logs
```

## Quick Start

### Prerequisites

- **Docker** and **Docker Compose** installed
- **Node.js** (v18+) for import scripts
- **Pandoc** for MediaWiki conversion
- **Python 3** for link fixing script

### 1. Initial Setup

```bash
# Clone or navigate to the project directory
cd PAWS_WikiJS

# Copy environment template
cp .env.example .env

# Edit .env and set secure passwords
# - DB_PASS: PostgreSQL password
# - SESSION_SECRET: Random secret string
```

### 2. Start WikiJS

```bash
# Start WikiJS and PostgreSQL
docker-compose up -d

# Check logs
docker-compose logs -f wikijs
```

WikiJS will be available at `http://localhost:3000`

### 3. Initial Configuration

1. Open `http://localhost:3000` in your browser
2. Complete the setup wizard:
   - Create admin account
   - Configure site name: "Pitt PAWS Wiki"
   - Set up database (already configured via Docker)
3. Apply custom theme:
   - Go to **Administration → Rendering → Custom CSS**
   - Copy contents of `theme/custom.css` and paste
   - Save
4. Upload logo:
   - Go to **Administration → UI → Logo**
   - Upload official University of Pittsburgh logo
   - Recommended: 200px width, transparent background

### 4. Content Migration

See [MIGRATION_PLAN.md](MIGRATION_PLAN.md) for detailed steps. Quick overview:

```bash
# 1. Export from MediaWiki (use MediaWiki's dumpBackup.php or Special:Export)
# Save as: mediawiki-dump.xml

# 2. Convert to Markdown
# Linux/Mac:
./scripts/convert-mediawiki.sh mediawiki-dump.xml content/pages

# Windows:
.\scripts\convert-mediawiki.ps1 -InputXml mediawiki-dump.xml -OutputDir content\pages

# 3. Fix internal links
python scripts/fix-links.py content/pages --verbose --report

# 4. Review converted content and fix any issues

# 5. Get API key from WikiJS (Administration → API)

# 6. Import to WikiJS (test first with --dry-run)
node scripts/import-to-wikijs.js YOUR_API_KEY content/pages --dry-run

# 7. Import for real
node scripts/import-to-wikijs.js YOUR_API_KEY content/pages
```

## Theme & Branding

The theme uses official University of Pittsburgh colors:
- **Pitt Royal Blue**: #003594
- **Pitt Gold**: #FFB81C
- **New Sky**: #DBEEFF
- **Medium Blue**: #00205B

See `theme/README.md` for customization details.

## Documentation

- **[MIGRATION_PLAN.md](MIGRATION_PLAN.md)** - Complete migration strategy and checklist
- **[scripts/README.md](scripts/README.md)** - Script usage and workflow
- **[theme/README.md](theme/README.md)** - Theme customization guide

## Development

### Stopping WikiJS

```bash
docker-compose down
```

### Viewing Logs

```bash
# All services
docker-compose logs -f

# Just WikiJS
docker-compose logs -f wikijs

# Just database
docker-compose logs -f postgres
```

### Backing Up

```bash
# Backup database
docker-compose exec postgres pg_dump -U wikijs wikijs > backup-$(date +%Y%m%d).sql

# Backup content and media
tar -czf backup-content-$(date +%Y%m%d).tar.gz content/ data/storage/
```

### Restoring

```bash
# Restore database
docker-compose exec -T postgres psql -U wikijs wikijs < backup-YYYYMMDD.sql
```

## Troubleshooting

### WikiJS won't start

- Check Docker is running: `docker ps`
- Check logs: `docker-compose logs wikijs`
- Verify `.env` file exists and has correct values
- Ensure port 3000 is not in use

### Database connection errors

- Verify PostgreSQL container is running: `docker-compose ps`
- Check database credentials in `.env`
- Wait a few seconds after starting - database needs time to initialize

### Import script fails

- Verify WikiJS is accessible at the URL in the script
- Check API key has write permissions
- Review error messages for specific issues
- Try importing a single file first to test

### Theme not applying

- Clear browser cache
- Check CSS was saved in WikiJS admin panel
- Verify no syntax errors in `custom.css`
- Check browser console for errors

## Migration Timeline

Estimated timeline for complete migration:
- **Planning & Inventory**: 1-2 weeks
- **Export & Conversion**: 2-4 weeks
- **WikiJS Setup**: 1 week
- **Theming**: 1-2 weeks
- **Import**: 1-2 weeks
- **Testing**: 2-3 weeks
- **Deployment**: 1 week

**Total: 9-15 weeks** (varies with content volume and complexity)

## Support & Resources

- **WikiJS Documentation**: https://docs.requarks.io/
- **Pandoc User's Guide**: https://pandoc.org/MANUAL.html
- **University of Pittsburgh Brand Guidelines**: https://www.brand.pitt.edu/
- **MediaWiki Export**: https://www.mediawiki.org/wiki/Manual:DumpBackup.php

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## Contributing

This is a migration project for the PAWS Lab. For questions or issues related to the migration process, please refer to the migration plan or create an issue.

---

**Status**: Ready for content migration. All infrastructure and tooling is in place.
