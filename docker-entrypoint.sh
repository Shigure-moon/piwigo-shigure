#!/bin/bash
set -e

# Configure Apache to listen on Railway's PORT (default 80)
PORT=${PORT:-80}
sed -i "s/Listen 80/Listen ${PORT}/" /etc/apache2/ports.conf
sed -i "s/<VirtualHost \*:80>/<VirtualHost *:${PORT}>/" /etc/apache2/sites-available/000-default.conf 2>/dev/null || true

# Always create/update database config from environment variables
# This ensures PHPWG_INSTALLED is always set, preventing reinstallation
mkdir -p /var/www/html/local/config

# Get database credentials from environment variables
DB_HOST_VAL=${DB_HOST:-mysql3.sqlpub.com}
DB_PORT_VAL=${DB_PORT:-3308}
DB_NAME_VAL=${DB_NAME:-piwigo_shigure}
DB_USER_VAL=${DB_USER:-shigure_shigure}
DB_PASSWORD_VAL=${DB_PASSWORD:-}

cat > /var/www/html/local/config/database.inc.php <<EOF
<?php
\$conf['dblayer'] = 'mysqli';
\$conf['db_base'] = '${DB_NAME_VAL}';
\$conf['db_user'] = '${DB_USER_VAL}';
\$conf['db_password'] = '${DB_PASSWORD_VAL}';
\$conf['db_host'] = '${DB_HOST_VAL}:${DB_PORT_VAL}';

\$prefixeTable = 'piwigo_';

define('PHPWG_INSTALLED', true);
define('PWG_CHARSET', 'utf-8');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
EOF

chown www-data:www-data /var/www/html/local/config/database.inc.php
chmod 644 /var/www/html/local/config/database.inc.php

# Verify the file was created and contains PHPWG_INSTALLED
if ! grep -q "PHPWG_INSTALLED" /var/www/html/local/config/database.inc.php; then
    echo "ERROR: database.inc.php was not created correctly!" >&2
    exit 1
fi

# Ensure local/config directory exists with proper permissions
mkdir -p /var/www/html/local/config
chown -R www-data:www-data /var/www/html/local
chmod -R 755 /var/www/html/local
chmod -R 775 /var/www/html/local/config

# Set proper permissions
chown -R www-data:www-data /var/www/html/_data
chmod -R 777 /var/www/html/_data

# Execute the main command
exec "$@"

