# WikiJS Setup Guide

This guide walks you through setting up WikiJS for the PAWS Wiki migration.

## Step-by-Step Setup

### 1. Install Prerequisites

#### Docker & Docker Compose
- **Windows**: Install [Docker Desktop](https://www.docker.com/products/docker-desktop)
- **Mac**: Install [Docker Desktop](https://www.docker.com/products/docker-desktop)
- **Linux**: 
  ```bash
  # Ubuntu/Debian
  sudo apt-get update
  sudo apt-get install docker.io docker-compose
  
  # Start Docker service
  sudo systemctl start docker
  sudo systemctl enable docker
  ```

#### Pandoc (for MediaWiki conversion)
- **Windows**: Download from [pandoc.org/installing.html](https://pandoc.org/installing.html)
- **Mac**: `brew install pandoc`
- **Linux**: `sudo apt-get install pandoc`

#### Node.js (for import scripts)
- Download from [nodejs.org](https://nodejs.org/) (v18 or later)
- Verify: `node --version`

#### Python 3 (for link fixing)
- Usually pre-installed on Mac/Linux
- **Windows**: Download from [python.org](https://www.python.org/downloads/)

### 2. Configure Environment

```bash
# Copy the example environment file
cp .env.example .env

# Edit .env with your preferred editor
# Windows: notepad .env
# Mac/Linux: nano .env or vim .env
```

**Required changes in `.env`:**
- `DB_PASS`: Set a strong password for PostgreSQL
- `SESSION_SECRET`: Generate a random string (you can use: `openssl rand -hex 32`)

**Optional changes:**
- `WIKI_PORT`: Change if 3000 is already in use
- `WIKI_HOST`: Set to your domain when deploying

### 3. Start WikiJS

```bash
# Start all services
docker-compose up -d

# Check status
docker-compose ps

# View logs (Ctrl+C to exit)
docker-compose logs -f
```

Wait for the message: "Wiki.js is ready to accept connections"

### 4. Initial WikiJS Configuration

1. **Open WikiJS in browser**
   - Navigate to `http://localhost:3000`
   - You should see the setup wizard

2. **Complete Setup Wizard**
   - **Site Name**: "Pitt PAWS Wiki"
   - **Site URL**: `http://localhost:3000` (or your domain)
   - **Admin Email**: Your email address
   - **Admin Password**: Create a strong password
   - **Database**: Should auto-detect PostgreSQL
     - Host: `postgres`
     - Port: `5432`
     - Database: `wikijs`
     - User: `wikijs`
     - Password: (from your `.env` file)

3. **Apply Custom Theme**
   - Go to **Administration** (gear icon in top right)
   - Navigate to **Rendering** → **Custom CSS**
   - Open `theme/custom.css` in a text editor
   - Copy all contents
   - Paste into the Custom CSS field
   - Click **Save**

4. **Upload Logo**
   - Go to **Administration** → **UI** → **Logo**
   - Upload the official University of Pittsburgh logo
   - Recommended specifications:
     - Format: PNG or SVG
     - Width: 200px
     - Background: Transparent
     - Maintain aspect ratio

5. **Configure Storage** (if needed)
   - Go to **Administration** → **Storage**
   - Default (local filesystem) should work fine
   - For production, consider cloud storage (S3, etc.)

### 5. Create API Key (for import script)

1. Go to **Administration** → **API**
2. Click **Create New Key**
3. Set permissions:
   - **Read**: Yes
   - **Write**: Yes (needed for import)
4. Copy the API key (you'll need it for the import script)
5. Save it securely - you won't be able to see it again

### 6. Test the Setup

1. **Create a test page**
   - Click **+** button or **Create Page**
   - Add some content
   - Save and verify it displays correctly

2. **Verify theme**
   - Check that colors match Pitt branding
   - Verify logo displays
   - Test navigation

3. **Test API** (optional)
   ```bash
   # Replace YOUR_API_KEY with your actual key
   curl -H "Authorization: Bearer YOUR_API_KEY" \
        http://localhost:3000/api/pages
   ```

## Next Steps

Once WikiJS is set up and configured:

1. **Export content from MediaWiki** (see MIGRATION_PLAN.md)
2. **Convert to Markdown** using the conversion scripts
3. **Fix links** using the link fixing script
4. **Import content** using the import script

See [MIGRATION_PLAN.md](MIGRATION_PLAN.md) for the complete migration process.

## Common Issues

### Port Already in Use

If port 3000 is already in use:
1. Edit `.env` and change `WIKI_PORT=3000` to another port (e.g., `3001`)
2. Restart: `docker-compose down && docker-compose up -d`
3. Access at `http://localhost:3001`

### Database Connection Failed

1. Check PostgreSQL is running: `docker-compose ps`
2. Verify credentials in `.env` match what you entered in setup wizard
3. Check logs: `docker-compose logs postgres`
4. Try restarting: `docker-compose restart`

### Theme Not Loading

1. Clear browser cache (Ctrl+Shift+Delete or Cmd+Shift+Delete)
2. Verify CSS was saved in admin panel
3. Check for syntax errors in browser console (F12)
4. Try hard refresh (Ctrl+F5 or Cmd+Shift+R)

### Can't Access WikiJS

1. Check Docker is running: `docker ps`
2. Check WikiJS container: `docker-compose ps`
3. Check logs: `docker-compose logs wikijs`
4. Verify firewall isn't blocking port 3000

## Maintenance

### Regular Backups

```bash
# Backup script (save as backup.sh or backup.ps1)
#!/bin/bash
DATE=$(date +%Y%m%d)

# Backup database
docker-compose exec postgres pg_dump -U wikijs wikijs > "backup-db-$DATE.sql"

# Backup content
tar -czf "backup-content-$DATE.tar.gz" content/ data/storage/

echo "Backup complete: backup-db-$DATE.sql and backup-content-$DATE.tar.gz"
```

### Updates

```bash
# Pull latest WikiJS image
docker-compose pull wikijs

# Restart with new image
docker-compose up -d

# Check logs for any issues
docker-compose logs -f wikijs
```

### Monitoring

```bash
# Check container status
docker-compose ps

# View resource usage
docker stats

# Check disk usage
docker system df
```

---

For more detailed information, see [MIGRATION_PLAN.md](MIGRATION_PLAN.md) and [scripts/README.md](scripts/README.md).

