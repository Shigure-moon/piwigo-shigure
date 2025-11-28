# Piwigo Shigure - Custom Gallery Theme

Custom Piwigo installation with Weweb-inspired design and "shigure" branding.

## Features

- Custom "stripped" theme with modern design
- Dark theme by default
- Custom logo and branding
- Album navigation with archive dropdown
- Responsive design
- Custom banner with shader text effects

## Deployment on Railway

### Prerequisites

- Railway account
- MySQL database (provided: mysql3.sqlpub.com:3308)

### Environment Variables

Set these in Railway dashboard:

```
DB_HOST=mysql3.sqlpub.com
DB_PORT=3308
DB_NAME=piwigo_shigure
DB_USER=shigure_shigure
DB_PASSWORD=r3rR9AR4U7NVNyHT
```

### Deployment Steps

1. Connect your GitHub repository to Railway
2. Create a new project in Railway
3. Add MySQL service (or use external database)
4. Set environment variables
5. Deploy

The application will automatically:
- Create database configuration from environment variables
- Set up proper file permissions
- Start Apache web server

### First Time Setup

After deployment, visit your Railway URL and complete the Piwigo installation wizard.

## Local Development

### Using Docker

```bash
docker build -t piwigo-shigure .
docker run -p 8080:80 \
  -e DB_HOST=mysql3.sqlpub.com \
  -e DB_PORT=3308 \
  -e DB_NAME=piwigo_shigure \
  -e DB_USER=shigure_shigure \
  -e DB_PASSWORD=r3rR9AR4U7NVNyHT \
  piwigo-shigure
```

## Project Structure

```
.
├── config/www/          # Piwigo core files
│   ├── themes/
│   │   ├── stripped/    # Custom theme
│   │   └── standard_pages/
│   └── local/           # Local configuration (gitignored)
├── gallery/              # Gallery images (gitignored)
├── Dockerfile           # Docker configuration
├── docker-entrypoint.sh # Entrypoint script
└── railway.json         # Railway configuration
```

## Custom Theme Files

- `themes/stripped/template/header.tpl` - Header with navigation
- `themes/stripped/css/modern.css` - Main stylesheet
- `themes/stripped/js/banner-shader-text.js` - Banner effects
- `themes/stripped/themeconf.inc.php` - Theme configuration

## License

Piwigo is licensed under GPL v2. See `config/www/COPYING.txt` for details.

