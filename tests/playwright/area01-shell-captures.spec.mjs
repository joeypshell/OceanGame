import { test } from "@playwright/test";
import {
  bootGame,
  capture,
  stageArea01CentralDrop,
  stageArea01DeepSpine,
  stageArea01LeftShelfCave,
  stageArea01RightChamber,
  stageArea01RightShelfPocket,
  stageArea01SurfaceEntry,
  stageArea01WestChamber,
} from "./visual-helpers.mjs";

test.describe("OceanGame Area 01 shell captures", () => {
  test("captures representative first-room shell states", async ({ page }, testInfo) => {
    await bootGame(page);

    await stageArea01SurfaceEntry(page);
    await capture(page, testInfo, "area01-surface-entry", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "area01_surface_entry",
    });

    await stageArea01LeftShelfCave(page);
    await capture(page, testInfo, "area01-left-shelf-cave", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "area01_left_shelf_cave",
    });

    await stageArea01RightShelfPocket(page);
    await capture(page, testInfo, "area01-right-shelf-pocket", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "area01_right_shelf_pocket",
    });

    await stageArea01CentralDrop(page);
    await capture(page, testInfo, "area01-central-drop", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "area01_central_drop",
    });

    await stageArea01WestChamber(page);
    await capture(page, testInfo, "area01-west-chamber", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "area01_west_chamber",
    });

    await stageArea01RightChamber(page);
    await capture(page, testInfo, "area01-right-chamber", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "area01_right_chamber",
    });

    await stageArea01DeepSpine(page);
    await capture(page, testInfo, "area01-deep-spine", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "area01_deep_spine",
    });

    await stageArea01CentralDrop(page);
    await page.keyboard.press("F10");
    await capture(page, testInfo, "area01-source-map-overlay", {
      result: "diving",
      debug_telemetry: true,
      area01_source_map_overlay: true,
      active_stats_visible: true,
      route_stage: "area01_central_drop",
    });
  });
});
