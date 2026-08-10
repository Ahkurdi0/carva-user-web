#!/usr/bin/env bash
# One-shot deploy for app.carvarent.com on the Contabo server.
# Run from inside the carva-web/ directory on the SERVER:
#   bash deploy/deploy.sh
set -euo pipefail

DOMAIN="app.carvarent.com"

echo "==> Node version: $(node -v 2>/dev/null || echo 'NOT INSTALLED — need Node 20+')"

# 1) Env — written BEFORE the build (NEXT_PUBLIC_* is baked in at build time)
cat > .env.local <<'EOF'
API_UPSTREAM=https://carvarent.com/api/v1
NEXT_PUBLIC_IMAGE_BASE=https://kcarsbucket.s3.amazonaws.com
EOF
echo "==> wrote .env.local"

# 2) Install deps + build
npm ci
npm run build

# 3) PM2 (web app on :3001, separate from the API on :3000)
if ! command -v pm2 >/dev/null 2>&1; then sudo npm i -g pm2; fi
pm2 start ecosystem.config.js || pm2 reload carva-web
pm2 save

# 4) nginx reverse proxy
sudo cp deploy/nginx.conf /etc/nginx/sites-available/carva-web
sudo ln -sf /etc/nginx/sites-available/carva-web /etc/nginx/sites-enabled/carva-web
sudo nginx -t && sudo systemctl reload nginx

echo ""
echo "==> Live (HTTP) at http://$DOMAIN"
echo "==> Enable HTTPS with:  sudo certbot --nginx -d $DOMAIN"
