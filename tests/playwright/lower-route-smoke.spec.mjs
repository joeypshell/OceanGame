import { expect, test } from "@playwright/test";
import { assertVisualState, bootGame, stageBlackwaterRoute, stageDuskTrenchRoute, stageHollowReefReturn, stageHollowReefRoute, stageWideReefChamber } from "./visual-helpers.mjs";

test.describe("OceanGame lower-route scripted smoke", () => {
  test("stages the long lower route without screenshots or visible debug telemetry", async ({ page }) => {
    await bootGame(page);
    await assertVisualState(page, {
      result: "ready",
      debug_telemetry: false,
      run_panel_visible: true
    });

    await page.keyboard.press("F6");
    await page.waitForTimeout(500);
    await assertVisualState(page, {
      result: "ready",
      debug_telemetry: false,
      run_panel_visible: true
    });

    await stageBlackwaterRoute(page);
    await expect.poll(() => page.evaluate(() => window.__oceangameDebugCommand || "")).toBe("");
    await assertVisualState(page, {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "blackwater_route",
      blackwater_trace_recovered: false
    });

    await stageDuskTrenchRoute(page);
    await assertVisualState(page, {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "dusk_trench_route",
      dusk_trench_reached: true
    });

    await stageHollowReefRoute(page);
    await assertVisualState(page, {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "hollow_reef_route",
      dusk_trench_reached: true,
      hollow_reef_reading_recovered: false
    });

    await stageHollowReefReturn(page);
    await assertVisualState(page, {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "hollow_reef_return",
      dusk_trench_reached: true,
      hollow_reef_reading_recovered: true
    });

    await stageWideReefChamber(page);
    await assertVisualState(page, {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "wide_reef_chamber",
      dusk_trench_reached: true,
      hollow_reef_reading_recovered: true
    });

    const state = await page.evaluate(() => window.__oceangameVisualState ?? {});
    expect(state.player_in_base).toBe(false);
    expect(state.has_left_base).toBe(true);
    expect(state.depth_meters).toBeGreaterThan(0);
  });
});
