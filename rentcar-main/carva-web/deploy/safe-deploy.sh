#!/usr/bin/env bash
# Safe deploy for carva-web: the live site keeps running while a new build
# is made somewhere else; only a finished, working build replaces it, and
# if the new one doesn't answer, the previous one comes back by itself.
#
# Run from the git checkout (on the server):
#   cd ~/app/carva-user-web/rentcar-main/carva-web
#   git pull origin claude/inspiring-ritchie-ewb2gn
#   sudo bash deploy/safe-deploy.sh
#
# Live site:   /var/www/carva-web             (service runs .next/standalone)
# Build here:  /var/www/carva-web-build       (scratch, rebuilt every time)
# Previous:    /var/www/carva-web-previous    (for rollback)
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LIVE=/var/www/carva-web
BUILD=/var/www/carva-web-build
PREV=/var/www/carva-web-previous
SERVICE=carvaweb
PORT=3001

say() { echo "==> $*"; }
health() { curl -s -o /dev/null -w '%{http_code}' --max-time 15 "http://127.0.0.1:${PORT}$1" || echo 000; }

[ "$(id -u)" = "0" ] || { echo "Run with sudo."; exit 1; }
command -v rsync >/dev/null || { echo "rsync missing: sudo apt-get install -y rsync"; exit 1; }
[ -f "$LIVE/.env.production" ] || echo "!! $LIVE/.env.production not found — build will use defaults."

say "1/6 Copy the source into a separate build folder (live site untouched)"
mkdir -p "$BUILD"
rsync -a --delete \
  --exclude node_modules --exclude .next --exclude data --exclude .git --exclude '.env*' \
  "$SRC/" "$BUILD/"
# The site's own settings (API address etc.) come from the live folder.
cp -a "$LIVE"/.env.production "$BUILD"/ 2>/dev/null || true
rm -f "$BUILD/.env.local"

say "2/6 Install and build (takes a few minutes)"
cd "$BUILD"
npm ci --no-audit --no-fund >/tmp/carvaweb-npm.log 2>&1 || { tail -30 /tmp/carvaweb-npm.log; echo "!! npm ci failed — live site NOT changed."; exit 1; }
if ! npm run build >/tmp/carvaweb-build.log 2>&1; then
  tail -40 /tmp/carvaweb-build.log
  echo "!! Build failed — live site NOT changed."
  exit 1
fi
[ -f .next/standalone/server.js ] || { echo "!! No standalone server.js — live site NOT changed."; exit 1; }
[ -d public ] && cp -r public .next/standalone/
cp -r .next/static .next/standalone/.next/

say "3/6 Keep the current site as 'previous' (for rollback)"
rm -rf "$PREV"
cp -a "$LIVE/.next/standalone" "$PREV"

say "4/6 Put the new build live"
rsync -a --delete "$BUILD/.next/standalone/" "$LIVE/.next/standalone/"
# Also keep the live source folder in step with what's running.
rsync -a --exclude node_modules --exclude .next --exclude data --exclude .git --exclude '.env*' "$SRC/" "$LIVE/"
# The service (www-data) must be able to write its page cache and visit log.
mkdir -p "$LIVE/.next/standalone/.next/cache" "$LIVE/data"
chown -R www-data:www-data "$LIVE/.next/standalone/.next/cache" "$LIVE/data"

say "5/6 Restart and check"
systemctl restart "$SERVICE"
ok=0
for i in 1 2 3 4 5 6 7 8 9 10; do
  sleep 2
  if [ "$(health /)" = "200" ]; then ok=1; break; fi
done

if [ "$ok" != "1" ]; then
  say "!! New site doesn't answer — putting the previous one back"
  rsync -a --delete "$PREV/" "$LIVE/.next/standalone/"
  systemctl restart "$SERVICE"
  sleep 3
  echo "Previous site back: $(health /). Build log: /tmp/carvaweb-build.log"
  exit 1
fi

say "6/6 Done"
echo "   /        -> $(health /)"
echo "   /verify  -> $(health /verify)"
echo "   /advertise -> $(health /advertise)"
echo "✅ Website updated."
