# Quick Start Guide

Get WikiJS up and running in 5 minutes.

## Prerequisites Check

- [ ] Docker installed and running
- [ ] Port 3000 available
- [ ] Text editor ready

## Setup (5 Steps)

### 1. Configure Environment
```bash
cp .env.example .env
# Edit .env and set DB_PASS and SESSION_SECRET
```

### 2. Start Services
```bash
docker-compose up -d
```

### 3. Access WikiJS
Open `http://localhost:3000` and complete the setup wizard.

### 4. Apply Theme
- Go to **Administration → Rendering → Custom CSS**
- Copy/paste contents of `theme/custom.css`
- Save

### 5. Upload Logo
- Go to **Administration → UI → Logo**
- Upload Pitt logo

## You're Ready!

WikiJS is now configured with University of Pittsburgh branding.

## Next: Content Migration

1. Export from MediaWiki → `mediawiki-dump.xml`
2. Convert: `./scripts/convert-mediawiki.sh mediawiki-dump.xml content/pages`
3. Fix links: `python scripts/fix-links.py content/pages`
4. Import: `node scripts/import-to-wikijs.js YOUR_API_KEY content/pages`

See [MIGRATION_PLAN.md](MIGRATION_PLAN.md) for details.

