import { test } from "@playwright/test";
import { bootGame, capture, holdKey, holdKeys } from "./visual-helpers.mjs";

test.describe("OceanGame mobile-like landscape visual smoke", () => {
  test("captures active HUD and lower-route views at a phone-like landscape viewport", async ({ page }, testInfo) => {
    await bootGame(page);
    await capture(page, testInfo, "mobile-like-surface-ready", {
      result: "ready",
      surface_tab: "result",
      debug_telemetry: false,
      run_panel_visible: true,
    });

    await page.keyboard.press("Enter");
    await page.waitForTimeout(600);
    await holdKey(page, "ArrowDown", 900);
    await capture(page, testInfo, "mobile-like-active-dive", {
      result: "diving",
      oxygen_state: "normal",
      debug_telemetry: false,
      active_stats_visible: true,
    });

    await holdKeys(page, ["ArrowRight", "ArrowDown"], 8_500);
    await capture(page, testInfo, "mobile-like-lower-route-pressure-gate", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
    });
  });
});
