/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  env: {
    HASURA_ENDPOINT: process.env.HASURA_ENDPOINT,
    HASURA_ADMIN_SECRET: process.env.HASURA_ADMIN_SECRET,
  },
};

module.exports = nextConfig;
