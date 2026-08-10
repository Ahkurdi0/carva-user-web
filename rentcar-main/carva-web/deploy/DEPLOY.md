# Deploying carva-web to Contabo (served at carvarent.com root)

The web app is a Next.js 16 app with a **server-side proxy**, so it needs a Node
runtime — it can't be hosted as static files. It runs as a Node process on
`127.0.0.1:3001` behind Nginx. The Express backend keeps running on
`127.0.0.1:3000`; Nginx sends `/api/v1` to it and everything else to the web app.

```
browser ──https──> Nginx (carvarent.com:443)
                     ├── /api/v1/*  ──> 127.0.0.1:3000  (Express backend, unchanged)
                     └── /*         ──> 127.0.0.1:3001  (Next.js web app)
                                          └── /api/proxy/* forwards server-side
                                              to 127.0.0.1:3000/api/v1
```

## 0. Prereqs on the server
- Node 20+ (you're on 24 locally — match it: `node -v`)
- Nginx, with the existing Let's Encrypt cert for carvarent.com
- A user that owns the app dir (examples below use `www-data`)

## 1. Get the code onto the server
Pick one:
- **git**: clone the repo and `cd` into `carva-web`, OR
- **rsync from Windows** (exclude build/deps + the dev env file):
  ```bash
  rsync -avz --exclude node_modules --exclude .next --exclude .env.local \
    ./carva-web/  user@carvarent.com:/var/www/carva-web/
  ```
Target dir used throughout: `/var/www/carva-web`.

> ⚠️ **Do NOT copy `.env.local` to the server.** In Next.js `.env.local`
> overrides `.env.production`, so the dev value (`https://carvarent.com/api/v1`)
> would silently replace the localhost upstream. Ship `.env.production` only.
> Verify on the server: `ls -la /var/www/carva-web/.env*` — there should be NO
> `.env.local`.

## 2. Install + build (on the server)
The app uses **standalone output** (`output: 'standalone'` in next.config.ts):
the build emits a self-contained `.next/standalone/` with `server.js` and only
the traced runtime deps — no full `node_modules` needed to *run* it.

```bash
cd /var/www/carva-web
npm ci                 # needed to BUILD (dev deps: tailwind, etc.)
npm run build          # emits .next/standalone/ + server.js

# standalone does NOT include public/ or .next/static — copy them in once,
# so server.js serves them (re-run this after every build):
cp -r public .next/standalone/ 2>/dev/null || true
cp -r .next/static .next/standalone/.next/
```
> ⚠️ **Build on the server (Linux), not on Windows.** The traced `node_modules`
> can contain platform-specific native binaries; a Windows-built standalone
> won't run on Linux. Build where you deploy.

`.env.production` (committed) points the proxy at `http://127.0.0.1:3000/api/v1`
and is traced into `.next/standalone/` automatically. Confirm that's your
backend's address; edit before building if the backend moves.

> After a successful build + copy you can run from `.next/standalone/` alone;
> the top-level `node_modules` is only needed to rebuild.

## 3. Run it as a service
```bash
sudo cp deploy/carva-web.service /etc/systemd/system/carva-web.service
# edit WorkingDirectory / User / node path inside if they differ
sudo systemctl daemon-reload
sudo systemctl enable --now carva-web
sudo systemctl status carva-web      # should be active (running)
curl -I http://127.0.0.1:3001        # should return 200
```
Logs: `journalctl -u carva-web -f`

## 4. Point Nginx at it
> This replaces the OLD root of carvarent.com (the previous marketing site).
> The `/api/v1` path is preserved, so the mobile app and API clients are unaffected.
```bash
sudo cp deploy/nginx-carvarent.conf /etc/nginx/sites-available/carvarent.com
sudo ln -sf /etc/nginx/sites-available/carvarent.com /etc/nginx/sites-enabled/
# remove any old conflicting server block for this domain first
sudo nginx -t            # must pass
sudo systemctl reload nginx
```

## 5. Verify
- https://carvarent.com → the web app loads
- https://carvarent.com/api/v1/... → still the backend (test a known POST endpoint)
- Log in on the site; the browser hits `/api/proxy/*` (same origin, no CORS) and
  the proxy reaches the backend over localhost.

## Updating later
```bash
cd /var/www/carva-web && git pull   # or rsync again
npm ci && npm run build
cp -r public .next/standalone/ 2>/dev/null || true
cp -r .next/static .next/standalone/.next/
sudo systemctl restart carva-web
```

## Notes / gotchas
- **Backend `trust proxy`**: the proxy forwards `x-forwarded-for` / `x-real-ip`.
  For correct per-IP rate limiting the Express app should `app.set('trust proxy', true)`.
- **Don't double-bind port 3000** — that's the backend. The web app is 3001.
- **CORS** stays locked to carvarent.com on the backend; that's fine because all
  browser traffic is same-origin through the proxy. No CORS change needed.
- If you later move the frontend off this box (e.g. Vercel), switch
  `API_UPSTREAM` back to `https://carvarent.com/api/v1`.
