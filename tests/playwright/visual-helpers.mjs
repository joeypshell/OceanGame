import { expect } from "@playwright/test";
import fs from "node:fs/promises";

export async function bootGame(page) {
  await page.goto("/");
  const canvas = page.locator("canvas").first();
  await expect(canvas).toBeVisible({ timeout: 60_000 });
  await page.waitForTimeout(2_000);

  const viewport = page.viewportSize() ?? { width: 1280, height: 720 };
  await canvas.click({
    position: {
      x: Math.floor(viewport.width / 2),
      y: Math.floor(viewport.height / 2),
    },
  });
  await page.keyboard.press("F9");
  await page.waitForTimeout(600);
  return canvas;
}

export async function holdKey(page, key, durationMs) {
  await page.keyboard.down(key);
  await page.waitForTimeout(durationMs);
  await page.keyboard.up(key);
}

export async function holdKeys(page, keys, durationMs) {
  for (const key of keys) {
    await page.keyboard.down(key);
  }
  await page.waitForTimeout(durationMs);
  for (const key of keys.reverse()) {
    await page.keyboard.up(key);
  }
}

export async function assertVisualState(page, expected) {
  await expect
    .poll(async () => {
      const state = await page.evaluate(() => window.__oceangameVisualState ?? null);
      if (!state) {
        return "missing visual state";
      }

      for (const [key, value] of Object.entries(expected)) {
        if (state[key] !== value) {
          return `${key}: expected ${value}, got ${state[key]}`;
        }
      }

      return "ok";
    })
    .toBe("ok");
}

export async function capture(page, testInfo, name, expectedState = {}) {
  await assertVisualState(page, expectedState);
  const visualState = await page.evaluate(() => window.__oceangameVisualState ?? {});
  const path = testInfo.outputPath(`${name}.png`);
  const metadataPath = testInfo.outputPath(`${name}.json`);
  await page.screenshot({ path });
  await fs.writeFile(
    metadataPath,
    `${JSON.stringify(
      {
        capture: name,
        expectedState,
        visualState,
        viewport: page.viewportSize(),
      },
      null,
      2,
    )}\n`,
  );
  testInfo.attachments.push({ name, path, contentType: "image/png" });
  testInfo.attachments.push({ name: `${name}-metadata`, path: metadataPath, contentType: "application/json" });
}

export async function stageOxygenState(page, oxygenState) {
  const command = oxygenState === "critical" ? "oxygen_critical" : "oxygen_low";
  await page.evaluate((nextCommand) => {
    window.__oceangameDebugCommand = nextCommand;
  }, command);
  await assertVisualState(page, {
    result: "diving",
    oxygen_state: oxygenState,
    active_stats_visible: true,
  });
}

export async function stageDaylightState(page, daylightCommand, remainingPercent) {
  await page.evaluate((nextCommand) => {
    window.__oceangameDebugCommand = nextCommand;
  }, daylightCommand);
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    daylight_visible: true,
    daylight_remaining_percent: remainingPercent,
  });
}

export async function stageSurfaceOxygenRefill(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "surface_oxygen_refill";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "surface_oxygen_refill",
    player_in_base: false,
    player_in_surface_oxygen_refill: true,
    surface_oxygen_refill_active: true,
    cargo_count: 1,
  });
}

export async function stageShipOffload(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "ship_offload";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "ship_offload_complete",
    player_in_base: true,
    cargo_count: 0,
    ship_offload_count: 1,
  });
}

export async function stageExpandedRoute(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "expanded_east_shelf_route";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "east_shelf_spur",
  });
}

export async function stageArea01SurfaceEntry(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "area01_surface_entry";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "area01_surface_entry",
  });
}

export async function stageArea01LeftShelfCave(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "area01_left_shelf_cave";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "area01_left_shelf_cave",
  });
}

export async function stageArea01RightShelfPocket(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "area01_right_shelf_pocket";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "area01_right_shelf_pocket",
  });
}

export async function stageArea01WestChamber(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "area01_west_chamber";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "area01_west_chamber",
  });
}

export async function stageArea01RightChamber(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "area01_right_chamber";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "area01_right_chamber",
  });
}

export async function stageArea01DeepSpine(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "area01_deep_spine";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "area01_deep_spine",
  });
}

export async function stageArea01CentralDrop(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "area01_central_drop";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "area01_central_drop",
  });
}

export async function stageEastShelfPocketPing(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "east_shelf_pocket_ping";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "east_shelf_pocket",
    east_shelf_pocket_ping_recovered: true,
  });
}

export async function stageLowerConnector(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "lower_connector";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "lower_connector",
  });
}

export async function stageBlueChimneyPocket(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "blue_chimney_pocket";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "blue_chimney_pocket",
  });
}

export async function stageBlueChimneyPayoff(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "blue_chimney_payoff";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "blue_chimney_payoff",
    blue_chimney_draft_reading_recovered: true,
  });
}

export async function stageSiltVeinFork(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "silt_vein_fork";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "silt_vein_fork",
    lantern_silt_sample_recovered: false,
  });
}

export async function stageBlackwaterRoute(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "blackwater_route";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "blackwater_route",
    blackwater_trace_recovered: false,
  });
}

export async function stageDuskTrenchRoute(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "dusk_trench_route";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "dusk_trench_route",
    dusk_trench_reached: true,
    glass_kelp_reading_recovered: false,
  });
}

export async function stageDuskTrenchPayoff(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "dusk_trench_payoff";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "dusk_trench_payoff",
    dusk_trench_reached: true,
    glass_kelp_reading_recovered: false,
  });
}

export async function stageDuskTrenchPayoffRecovered(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "dusk_trench_payoff_recovered";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "dusk_trench_payoff_recovered",
    dusk_trench_reached: true,
    glass_kelp_reading_recovered: true,
  });
}

export async function stageHollowReefRoute(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "hollow_reef_route";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "hollow_reef_route",
    dusk_trench_reached: true,
    hollow_reef_reading_recovered: false,
  });
}

export async function stageHollowReefPayoff(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "hollow_reef_payoff";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "hollow_reef_payoff",
    dusk_trench_reached: true,
    hollow_reef_reading_recovered: false,
  });
}

export async function stageHollowReefReturn(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "hollow_reef_return";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "hollow_reef_return",
    dusk_trench_reached: true,
    hollow_reef_reading_recovered: true,
  });
}

export async function stageWideReefChamber(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "wide_reef_chamber";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "wide_reef_chamber",
    dusk_trench_reached: true,
    hollow_reef_reading_recovered: true,
  });
}

export async function stageWideReefSalvageOpen(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "wide_reef_salvage_open";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "wide_reef_salvage_open",
    dusk_trench_reached: true,
    hollow_reef_reading_recovered: true,
    salvage_pocket_open: true,
  });
}

export async function stageOuterShelfSurvey(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "outer_shelf_survey";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "outer_shelf_survey",
    outer_shelf_survey_recovered: false,
    tideglass_sample_recovered: false,
    salvage_manifest_recovered: false,
  });
}

export async function stageOpenHatchResonanceAlcove(page) {
  await page.evaluate(() => {
    window.__oceangameDebugCommand = "open_hatch_resonance_alcove";
  });
  await assertVisualState(page, {
    result: "diving",
    active_stats_visible: true,
    route_stage: "open_hatch_resonance_alcove",
    resonance_alcove_research_recovered: true,
  });
}

export async function returnToBaseAndExtract(page) {
  await holdKey(page, "ArrowUp", 1_800);
  await page.waitForTimeout(300);
  await page.keyboard.press("Enter");
  await page.waitForTimeout(800);
}
