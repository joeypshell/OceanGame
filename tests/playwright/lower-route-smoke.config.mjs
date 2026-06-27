import { defineConfig, devices } from "@playwright/test";

const port = Number(process.env.OCEANGAME_WEB_PORT ?? 8060);
const host = process.env.OCEANGAME_WEB_HOST ?? "127.0.0.1";

export default defineConfig({
  testDir: ".",
  testMatch: "lower-route-smoke.spec.mjs",
  timeout: 45_000,
  expect: {
    timeout: 15_000
  },
  fullyParallel: false,
  reporter: [["list"], ["html", { open: "never", outputFolder: "../../playwright-report-lower-route" }]],
  outputDir: "../../test-results/playwright-lower-route",
  use: {
    baseURL: `http://${host}:${port}`,
    viewport: { width: 1280, height: 720 },
    deviceScaleFactor: 1,
    colorScheme: "dark",
    trace: "retain-on-failure",
    screenshot: "only-on-failure"
  },
  webServer: {
    command: "node serve-web.mjs",
    url: `http://${host}:${port}/`,
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
