# Deploying Carva Web on the Contabo server

The site is a Next.js **server** app (it has the `/api/proxy` route), so it runs
under Node behind nginx + PM2. These steps assume the backend already runs on
the same box.

## 1. Get the code on the server
Copy the `carva-web/` folder to the server, e.g. `/var/www/carva-web`.

## 2. Configure env (BEFORE building)
`NEXT_PUBLIC_*` vars are baked in at build time, so set them first. `.env.local`
should contain:

```
API_UPSTREAM=https://carvarent.com/api/v1
NEXT_PUBLIC_IMAGE_BASE=https://kcarsbucket.s3.amazonaws.com
```

The web app runs on **port 3001** (the backend uses 3000), so there's no clash.
If the web app sits on the same host as the API, you can point the proxy at the
backend locally to avoid a public round-trip:
```
API_UPSTREAM=http://127.0.0.1:3000/api/v1   # backend's local port
```

## 3. Build & run with PM2
```bash
cd /var/www/carva-web
npm ci
npm run build
npm i -g pm2          # if not installed
pm2 start ecosystem.config.js
pm2 save
pm2 startup           # follow the printed command so it survives reboots
```
The app now listens on `http://127.0.0.1:3001`.

## 4. nginx + HTTPS
```bash
cp deploy/nginx.conf /etc/nginx/sites-available/carva-web
ln -s /etc/nginx/sites-available/carva-web /etc/nginx/sites-enabled/
# edit server_name to your domain
nginx -t && systemctl reload nginx
certbot --nginx -d app.carvarent.com    # free HTTPS
```

## 5. Point a domain
Add a DNS A record (e.g. `app.carvarent.com`) → the server's IP.

## 6. Backend: trust the forwarded IP (recommended)
The web app forwards each visitor's IP to the API (`X-Forwarded-For` / `X-Real-IP`)
so per-IP rate limiters don't treat everyone as one client. For the backend to
honor it, add this near the top of `KCars-server/src/app.ts`:

```ts
app.set('trust proxy', true);
```

Without it, all proxied requests share the web server's IP and the auth/OTP rate
limiters may throttle real users.

## Updating later
```bash
cd /var/www/carva-web
git pull            # or re-copy files
npm ci
npm run build
pm2 reload carva-web
```

## PM2 cheat sheet
```bash
pm2 reload carva-web        # zero-downtime reload after a rebuild
pm2 restart carva-web       # hard restart
pm2 stop carva-web          # stop
pm2 logs carva-web          # tail logs
pm2 status                  # list processes
pm2 save                    # persist the process list (run after changes)
```

## Notes
- Brand logos load from a public car-logo CDN with a built-in fallback to a
  generic icon — no setup needed.
- Image uploads (new car, company/profile pictures) flow through the proxy;
  nginx `client_max_body_size` is set to 12m to allow them.
