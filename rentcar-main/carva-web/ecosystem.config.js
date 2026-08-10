// PM2 process config for the Carva web app.
//   pm2 start ecosystem.config.js
//   pm2 save && pm2 startup   (to survive reboots)
module.exports = {
  apps: [
    {
      name: "carva-web",
      script: "node_modules/next/dist/bin/next",
      args: "start -p 3001",
      cwd: __dirname,
      instances: 1,
      autorestart: true,
      max_memory_restart: "512M",
      env: {
        NODE_ENV: "production",
        PORT: "3001",
      },
    },
  ],
};
