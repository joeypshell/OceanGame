import { expect, test } from "@playwright/test";

async function bootGame(page) {
  await page.goto("/");
  const canvas = page.locator("canvas").first();
  await expect(canvas).toBeVisible({ timeout: 60_000 });
  await page.waitForTimeout(2_000);
  await canvas.click({ position: { x: 640, y: 360 } });
  await page.keyboard.press("F9");
  await page.waitForTimeout(600);
  return canvas;
}

async function holdKey(page, key, durationMs) {
  await page.keyboard.down(key);
  await page.waitForTimeout(durationMs);
  await page.keyboard.up(key);
}

async function holdKeys(page, keys, durationMs) {
  for (const key of keys) {
    await page.keyboard.down(key);
  }
  await page.waitForTimeout(durationMs);
  for (const key of keys.reverse()) {
    await page.keyboard.up(key);
  }
}

async function capture(page, testInfo, name) {
  const path = testInfo.outputPath(`${name}.png`);
  await page.screenshot({ path });
  testInfo.attachments.push({ name, path, contentType: "image/png" });
}

test.describe("OceanGame web visual smoke", () => {
  test("captures deterministic surface, active, result, upgrade, and lower-route views", async ({ page }, testInfo) => {
    await bootGame(page);
    await capture(page, testInfo, "surface-ready");

    await page.keyboard.press("Enter");
    await page.waitForTimeout(600);
    await holdKey(page, "ArrowDown", 900);
    await capture(page, testInfo, "active-dive");

    await page.keyboard.press("KeyR");
    await page.waitForTimeout(700);
    await page.keyboard.press("Enter");
    await page.waitForTimeout(300);
    await page.keyboard.press("Enter");
    await page.waitForTimeout(700);
    await capture(page, testInfo, "extraction-result");

    await page.keyboard.press("Enter");
    await page.waitForTimeout(500);
    await capture(page, testInfo, "upgrade-tab");

    await page.keyboard.press("KeyR");
    await page.waitForTimeout(700);
    await page.keyboard.press("F9");
    await page.waitForTimeout(500);
    await page.keyboard.press("Enter");
    await page.waitForTimeout(500);
    await holdKeys(page, ["ArrowRight", "ArrowDown"], 8_500);
    await capture(page, testInfo, "lower-route-pressure-gate");
  });
});
