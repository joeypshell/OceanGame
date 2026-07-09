import { expect, test } from "@playwright/test";

test("exported Web build starts without project-originated browser errors", async ({ page }) => {
  const consoleErrors = [];
  const pageErrors = [];
  const failedRequests = [];
  const failedResponses = [];

  page.on("console", (message) => {
    if (message.type() === "error") {
      consoleErrors.push(message.text());
    }
  });
  page.on("pageerror", (error) => pageErrors.push(error.message));
  page.on("requestfailed", (request) => {
    failedRequests.push(`${request.failure()?.errorText ?? "request failed"}: ${request.url()}`);
  });
  page.on("response", (response) => {
    if (response.status() >= 400) {
      failedResponses.push(`${response.status()} ${response.url()}`);
    }
  });

  const response = await page.goto("/");
  expect(response?.ok(), "Web entry document should load successfully").toBe(true);
  await expect(page.locator("canvas").first()).toBeVisible({ timeout: 60_000 });
  await expect.poll(() => page.evaluate(() => window.__oceangameVisualState != null)).toBe(true);
  await page.waitForTimeout(1_000);

  expect(consoleErrors, "Browser console errors should be empty").toEqual([]);
  expect(pageErrors, "Uncaught page errors should be empty").toEqual([]);
  expect(failedRequests, "Network request failures should be empty").toEqual([]);
  expect(failedResponses, "HTTP error responses should be empty").toEqual([]);
});
