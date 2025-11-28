#!/bin/bash
set -e

# Create database config from environment variables if not exists
if [ ! -f /var/www/html/local/config/database.inc.php ]; then
    mkdir -p /var/www/html/local/config
    
    cat > /var/www/html/local/config/database.inc.php <<EOF
<?php
\$conf['dblayer'] = 'mysqli';
\$conf['db_base'] = '${DB_NAME:-piwigo_shigure}';
\$conf['db_user'] = '${DB_USER:-shigure_shigure}';
\$conf['db_password'] = '${DB_PASSWORD}';
\$conf['db_host'] = '${DB_HOST:-mysql3.sqlpub.com}:${DB_PORT:-3308}';

\$prefixeTable = 'piwigo_';

define('PHPWG_INSTALLED', true);
define('PWG_CHARSET', 'utf-8');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
?>
EOF

    chown www-data:www-data /var/www/html/local/config/database.inc.php
    chmod 644 /var/www/html/local/config/database.inc.php
fi

# Set proper permissions
chown -R www-data:www-data /var/www/html/_data
chmod -R 777 /var/www/html/_data

# Execute the main command
exec "$@"

