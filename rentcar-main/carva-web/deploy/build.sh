#!/usr/bin/env bash
# One-shot build + deploy for carva-web (run ON the Contabo server).
#
#   ./deploy/build.sh           # install, build, stage assets, restart service
#   ./deploy/build.sh --no-restart   # build only, don't touch the service
#
# Run from the project root (the dir containing package.json):
#   cd /var/www/carva-web && ./deploy/build.sh
set -euo pipefail

SERVICE="carvaweb"
RESTART=1
[ "${1:-}" = "--no-restart" ] && RESTART=0

# Resolve project root from this script's location, so it works from anywhere.
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "==> carva-web deploy  (root: $ROOT)"

# Guard: standalone build must be configured, else there's no server.js to run.
if ! grep -q "standalone" next.config.ts 2>/dev/null; then
  echo "!! next.config.ts is not set to output: 'standalone' — aborting." >&2
  exit 1
fi

# Warn (don't fail) if a dev env file is present — it overrides .env.production.
if [ -f .env.local ]; then
  echo "!! WARNING: .env.local exists and overrides .env.production in Next.js."
  echo "   Remove it on the server so the proxy uses the localhost upstream."
fi

echo "==> Installing dependencies (npm ci)"
npm ci

echo "==> Building (next build, standalone)"
npm run build

echo "==> Staging public/ and .next/static into standalone"
# server.js does not serve these unless copied in; refresh them every build.
[ -d public ] && cp -r public .next/standalone/
rm -rf .next/standalone/.next/static
cp -r .next/static .next/standalone/.next/

# Visitor-analytics log dir (ANALYTICS_DATA_DIR in carvaweb.service). Kept here,
# outside .next/standalone, so it persists across rebuilds. Owned by the service
# user so the app can append visits.
echo "==> Ensuring analytics data dir ($ROOT/data)"
mkdir -p "$ROOT/data"
chown -R www-data:www-data "$ROOT/data" 2>/dev/null || true

if [ "$RESTART" -eq 1 ]; then
  echo "==> Restarting service: $SERVICE"
  if command -v systemctl >/dev/null 2>&1 && systemctl list-unit-files | grep -q "^${SERVICE}.service"; then
    sudo systemctl restart "$SERVICE"
    sleep 2
    sudo systemctl --no-pager --lines=0 status "$SERVICE" || true
    # Health check against the local port the service binds to.
    PORT="$(grep -oP 'PORT=\K[0-9]+' deploy/carvaweb.service | head -1)"; PORT="${PORT:-3001}"
    code="$(curl -s -o /dev/null -w '%{http_code}' "http://127.0.0.1:${PORT}/" || echo 000)"
    echo "==> Health check http://127.0.0.1:${PORT}/ -> ${code}"
    [ "$code" = "200" ] || { echo "!! Service not healthy (expected 200)."; exit 1; }
  else
    echo "!! systemd service '${SERVICE}' not installed — skipping restart."
    echo "   See deploy/DEPLOY.md step 3 to install it."
  fi
else
  echo "==> Build complete (--no-restart): start with"
  echo "   PORT=3001 HOSTNAME=127.0.0.1 node .next/standalone/server.js"
fi

echo "==> Done."
