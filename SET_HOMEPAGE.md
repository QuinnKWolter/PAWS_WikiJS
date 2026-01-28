# Setting the Main Page in WikiJS

## Your Main Page

Based on the import, your main page is located at:
- **File**: `content/import/pages/ns_0/new_main.md`
- **Title**: "New Main"
- **Path in WikiJS**: `/import/ns_0/new_main` (after import)

## Option 1: Set as Homepage via WikiJS Admin (Recommended)

1. **Start WikiJS** (if not already running):
   ```powershell
   docker-compose up -d
   ```

2. **Access WikiJS**:
   - Open `http://localhost:3000` in your browser
   - Log in as admin

3. **Import the page first** (if not already imported):
   - Go to **Pages** → **Create Page**
   - Or use the import script/API

4. **Set as Homepage**:
   - Go to **Administration** (gear icon)
   - Navigate to **UI** → **Homepage**
   - Select **Custom Page**
   - Enter the path: `/import/ns_0/new_main`
   - Or browse and select "New Main" from the page list
   - Click **Save**

## Option 2: Create a Redirect from Root

If you want the root URL (`/`) to show the main page:

1. **Create a page at root path**:
   - Go to **Pages** → **Create Page**
   - Set path to: `/` (or leave empty for root)
   - Title: "Home" or "PAWS Lab"
   - Content: Use the content from `new_main.md` or create a redirect

2. **Or use redirect**:
   - Create a page at `/` with content:
     ```markdown
     ---
     redirect: /import/ns_0/new_main
     ---
     ```

## Option 3: Copy Content to Root Page

1. **Read the main page content**:
   ```powershell
   Get-Content .\content\import\pages\ns_0\new_main.md
   ```

2. **Create a new page in WikiJS**:
   - Path: `/` (root)
   - Title: "PAWS Lab" or "Home"
   - Copy the content from `new_main.md`
   - Save

## Quick Test

To quickly test how the page looks:

1. **Import just this one page** (if using API):
   ```powershell
   # You'll need the import script and API key
   # Or manually create the page in WikiJS admin
   ```

2. **Or manually create it**:
   - Go to WikiJS admin
   - Create new page
   - Path: `/import/ns_0/new_main`
   - Copy content from `content/import/pages/ns_0/new_main.md`
   - Save and view

## Alternative: Use "PAWS" Page

If you prefer the `paws.md` page (which has "About PAWS" and recent news):
- **File**: `content/import/pages/ns_0/paws.md`
- **Title**: "PAWS"
- **Path**: `/import/ns_0/paws`

This page has more recent content and news updates.

## Recommended Approach

1. Import `new_main.md` first to test
2. If you like it, set it as homepage via Admin → UI → Homepage
3. Or import `paws.md` if you prefer that content
4. You can always change it later in the admin settings

