import { test } from "@playwright/test";
import { bootGame, capture, holdKey, holdKeys, returnToBaseAndExtract, stageEastShelfPocketPing, stageExpandedRoute, stageLowerConnector, stageOpenHatchResonanceAlcove, stageOxygenState } from "./visual-helpers.mjs";

test.describe("OceanGame web visual smoke", () => {
  test("captures deterministic surface, active, result, upgrade, and lower-route views", async ({ page }, testInfo) => {
    await bootGame(page);
    await capture(page, testInfo, "surface-ready", {
      result: "ready",
      surface_tab: "result",
      debug_telemetry: false,
      run_panel_visible: true,
    });

    await page.keyboard.press("Enter");
    await page.waitForTimeout(600);
    await holdKey(page, "ArrowDown", 900);
    await capture(page, testInfo, "active-dive", {
      result: "diving",
      oxygen_state: "normal",
      debug_telemetry: false,
      active_stats_visible: true,
    });

    await returnToBaseAndExtract(page);
    await capture(page, testInfo, "extraction-result", {
      result: "extracted",
      surface_tab: "result",
      debug_telemetry: false,
      run_panel_visible: true,
    });

    await page.keyboard.press("Enter");
    await page.waitForTimeout(500);
    await capture(page, testInfo, "upgrade-tab", {
      result: "extracted",
      surface_tab: "upgrades",
      debug_telemetry: false,
      upgrade_panel_visible: true,
    });

    await page.keyboard.press("KeyR");
    await page.waitForTimeout(700);
    await page.keyboard.press("F9");
    await page.waitForTimeout(500);
    await page.keyboard.press("Enter");
    await page.waitForTimeout(500);
    await holdKeys(page, ["ArrowRight", "ArrowDown"], 8_500);
    await capture(page, testInfo, "lower-route-pressure-gate", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
    });
  });

  test("captures staged Wreck Echo route and result readback views", async ({ page }, testInfo) => {
    await bootGame(page);
    await page.keyboard.press("F3");
    await page.waitForTimeout(400);
    await page.keyboard.press("Enter");
    await page.waitForTimeout(500);

    await page.keyboard.press("F6");
    await page.waitForTimeout(900);
    await capture(page, testInfo, "wreck-echo-route-staged", {
      result: "diving",
      debug_telemetry: true,
      active_stats_visible: true,
      wreck_echo_clue_recovered: false,
    });

    await page.keyboard.press("F6");
    await page.waitForTimeout(900);
    await capture(page, testInfo, "wreck-echo-result-readback", {
      result: "extracted",
      debug_telemetry: true,
      run_panel_visible: true,
      wreck_echo_clue_recovered: true,
    });

    await page.keyboard.press("F3");
    await page.waitForTimeout(400);
    await capture(page, testInfo, "wreck-echo-result-player-facing", {
      result: "extracted",
      debug_telemetry: false,
      run_panel_visible: true,
      wreck_echo_clue_recovered: true,
    });
  });

  test("captures the staged expanded East Shelf route view", async ({ page }, testInfo) => {
    await bootGame(page);
    await stageExpandedRoute(page);
    await capture(page, testInfo, "expanded-east-shelf-route-staged", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "east_shelf_spur",
    });
  });

  test("captures the staged East Shelf pocket interaction payoff", async ({ page }, testInfo) => {
    await bootGame(page);
    await stageEastShelfPocketPing(page);
    await capture(page, testInfo, "east-shelf-pocket-ping-staged", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "east_shelf_pocket",
      east_shelf_pocket_ping_recovered: true,
    });
  });

  test("captures the staged lower connector route view", async ({ page }, testInfo) => {
    await bootGame(page);
    await stageLowerConnector(page);
    await capture(page, testInfo, "lower-connector-staged", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "lower_connector",
    });
  });

  test("captures the staged open hatch and Resonance Alcove view", async ({ page }, testInfo) => {
    await bootGame(page);
    await stageOpenHatchResonanceAlcove(page);
    await capture(page, testInfo, "open-hatch-resonance-alcove-staged", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "open_hatch_resonance_alcove",
      resonance_alcove_research_recovered: true,
    });
  });

  test("captures active low and critical oxygen HUD states", async ({ page }, testInfo) => {
    await bootGame(page);
    await page.keyboard.press("Enter");
    await page.waitForTimeout(600);
    await holdKey(page, "ArrowDown", 2_000);

    await stageOxygenState(page, "low");
    await capture(page, testInfo, "active-low-oxygen", {
      result: "diving",
      oxygen_state: "low",
      debug_telemetry: false,
      active_stats_visible: true,
    });

    await stageOxygenState(page, "critical");
    await capture(page, testInfo, "active-critical-oxygen", {
      result: "diving",
      oxygen_state: "critical",
      debug_telemetry: false,
      active_stats_visible: true,
    });
  });
});
