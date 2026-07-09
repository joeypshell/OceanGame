import { defineConfig, devices } from "@playwright/test";

const port = Number(process.env.OCEANGAME_WEB_PORT ?? 8065);
const host = process.env.OCEANGAME_WEB_HOST ?? "127.0.0.1";

export default defineConfig({
  testDir: ".",
  testMatch: "web-release-smoke.spec.mjs",
  timeout: 60_000,
  expect: {
    timeout: 30_000
  },
  fullyParallel: false,
  reporter: "list",
  outputDir: "../../test-results/playwright-web-release",
  use: {
    baseURL: `http://${host}:${port}`,
    viewport: { width: 1280, height: 720 },
    trace: "retain-on-failure",
    screenshot: "off"
  },
  webServer: {
    command: "node serve-web.mjs",
    url: `http://${host}:${port}/`,
    env: {
      OCEANGAME_WEB_HOST: host,
      OCEANGAME_WEB_PORT: String(port)
    },
    reuseExistingServer: !process.env.CI,
    timeout: 30_000
  },
  projects: [
    {
      name: "chromium",
      use: { ...devices["Desktop Chrome"] }
    }
  ]
});
