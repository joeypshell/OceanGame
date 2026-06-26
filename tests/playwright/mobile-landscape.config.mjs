import { defineConfig } from "@playwright/test";

const port = Number(process.env.OCEANGAME_WEB_PORT ?? 8060);
const host = process.env.OCEANGAME_WEB_HOST ?? "127.0.0.1";

export default defineConfig({
  testDir: ".",
  testMatch: "mobile-landscape-smoke.spec.mjs",
  timeout: 90_000,
  expect: {
    timeout: 15_000,
  },
  fullyParallel: false,
  reporter: [["list"], ["html", { open: "never", outputFolder: "../../test-results/playwright-report-mobile-like" }]],
  outputDir: "../../test-results/playwright-mobile-like",
  use: {
    baseURL: `http://${host}:${port}`,
    viewport: { width: 960, height: 540 },
    deviceScaleFactor: 2,
    colorScheme: "dark",
    trace: "retain-on-failure",
    screenshot: "only-on-failure",
  },
  webServer: {
    command: "node serve-web.mjs",
    url: `http://${host}:${port}/`,
    reuseExistingServer: !process.env.CI,
    timeout: 30_000,
  },
  projects: [
    {
      name: "mobile-like-landscape",
    },
  ],
});
