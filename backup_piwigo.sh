#!/bin/bash
# Piwigo Custom Files Backup Script
# This script backs up all custom modifications to Piwigo

BACKUP_DIR="/home/shigure/docker_space/piwigo/backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="piwigo_custom_backup_${TIMESTAMP}"

echo "Creating backup: ${BACKUP_NAME}"

# Create backup directory
mkdir -p "${BACKUP_DIR}/${BACKUP_NAME}"

# Backup custom themes
echo "Backing up custom themes..."
mkdir -p "${BACKUP_DIR}/${BACKUP_NAME}/themes"
cp -r config/www/themes/stripped "${BACKUP_DIR}/${BACKUP_NAME}/themes/" 2>/dev/null
cp -r config/www/themes/standard_pages "${BACKUP_DIR}/${BACKUP_NAME}/themes/" 2>/dev/null

# Backup custom images and assets
echo "Backing up custom images..."
mkdir -p "${BACKUP_DIR}/${BACKUP_NAME}/themes/stripped/img"
if [ -d "config/www/themes/stripped/img/weweb" ]; then
    cp -r config/www/themes/stripped/img/weweb "${BACKUP_DIR}/${BACKUP_NAME}/themes/stripped/img/" 2>/dev/null
fi

# Create restore script
cat > "${BACKUP_DIR}/${BACKUP_NAME}/restore.sh" << 'EOF'
#!/bin/bash
# Piwigo Custom Files Restore Script
# Usage: ./restore.sh /path/to/piwigo/root

if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/piwigo/root"
    exit 1
fi

PIWIGO_ROOT="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Restoring Piwigo custom files to: ${PIWIGO_ROOT}"

# Restore themes
if [ -d "${SCRIPT_DIR}/themes/stripped" ]; then
    echo "Restoring stripped theme..."
    mkdir -p "${PIWIGO_ROOT}/config/www/themes/stripped"
    cp -r "${SCRIPT_DIR}/themes/stripped"/* "${PIWIGO_ROOT}/config/www/themes/stripped/"
fi

if [ -d "${SCRIPT_DIR}/themes/standard_pages" ]; then
    echo "Restoring standard_pages theme..."
    mkdir -p "${PIWIGO_ROOT}/config/www/themes/standard_pages"
    cp -r "${SCRIPT_DIR}/themes/standard_pages"/* "${PIWIGO_ROOT}/config/www/themes/standard_pages/"
fi

echo "Restore completed!"
echo "Please clear Piwigo template cache: rm -rf ${PIWIGO_ROOT}/config/www/_data/templates_c/*"
EOF

chmod +x "${BACKUP_DIR}/${BACKUP_NAME}/restore.sh"

# Create README
cat > "${BACKUP_DIR}/${BACKUP_NAME}/README.md" << 'EOF'
# Piwigo Custom Files Backup

This backup contains all custom modifications to the Piwigo installation.

## Contents

- `themes/stripped/` - Custom stripped theme with Weweb design
- `themes/standard_pages/` - Modified standard_pages theme for login page

## Restore Instructions

1. Copy this backup directory to your new Piwigo installation
2. Run the restore script:
   ```bash
   ./restore.sh /path/to/piwigo/root
   ```
3. Clear Piwigo template cache:
   ```bash
   rm -rf /path/to/piwigo/config/www/_data/templates_c/*
   ```
4. Set proper permissions:
   ```bash
   chown -R www-data:www-data /path/to/piwigo/config/www/themes
   ```

## Custom Modifications

- Logo: `themes/stripped/img/weweb/logo_simple.png` and `logo-text.png`
- Banner image: `themes/stripped/img/weweb/1111.png`
- Login background: `themes/stripped/img/weweb/2222.jpeg`
- Custom CSS: `themes/stripped/css/modern.css` and `modern-styles.css`
- Custom JavaScript: `themes/stripped/js/banner-shader-text.js`, `visual-effects.js`, etc.
- Custom templates: All `.tpl` files in `themes/stripped/template/`

## Notes

- Default theme style is set to 'dark' in `themeconf.inc.php`
- Gallery title is set to 'shigure'
- All Piwigo branding has been replaced with 'shigure'
EOF

# Create tar archive
echo "Creating archive..."
cd "${BACKUP_DIR}"
tar -czf "${BACKUP_NAME}.tar.gz" "${BACKUP_NAME}" 2>/dev/null

echo "Backup completed!"
echo "Location: ${BACKUP_DIR}/${BACKUP_NAME}"
echo "Archive: ${BACKUP_DIR}/${BACKUP_NAME}.tar.gz"
echo ""
echo "Backup size:"
du -sh "${BACKUP_DIR}/${BACKUP_NAME}"
du -sh "${BACKUP_DIR}/${BACKUP_NAME}.tar.gz" 2>/dev/null || echo "Archive creation may have failed"

