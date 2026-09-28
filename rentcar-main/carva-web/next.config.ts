import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Emit a self-contained .next/standalone server (traced deps only) so the
  // server doesn't need a full `node_modules`. Run with `node server.js`.
  output: "standalone",
};

export default nextConfig;
