import { test } from "@playwright/test";
import { bootGame, capture, holdKey, holdKeys, returnToBaseAndExtract, stageBlackwaterRoute, stageBlueChimneyPayoff, stageBlueChimneyPocket, stageDaylightState, stageDuskTrenchPayoff, stageDuskTrenchPayoffRecovered, stageDuskTrenchRoute, stageEastShelfPocketPing, stageExpandedRoute, stageHealthDamage, stageHollowReefPayoff, stageHollowReefReturn, stageHollowReefRoute, stageLowerConnector, stageOpenHatchResonanceAlcove, stageOuterShelfSurvey, stageOxygenState, stageShipOffload, stageSiltVeinFork, stageSurfaceOxygenRefill } from "./visual-helpers.mjs";

test.describe("OceanGame web visual smoke", () => {
  test("captures deterministic surface, active, result, upgrade, and lower-route views", async ({ page }, testInfo) => {
    await bootGame(page);
    await capture(page, testInfo, "surface-ready", {
      result: "ready",
      surface_tab: "result",
      debug_telemetry: false,
      status_debug_copy: false,
      run_panel_visible: true,
      dawn_priority_visible: true,
    });

    await page.keyboard.press("Enter");
    await page.waitForTimeout(600);
    await holdKey(page, "ArrowDown", 900);
    await capture(page, testInfo, "active-dive", {
      result: "diving",
      oxygen_state: "normal",
      debug_telemetry: false,
      status_debug_copy: false,
      active_stats_visible: true,
      touch_controls_visible: false,
      player_rendered: true,
      player_on_screen: true,
    });

    await returnToBaseAndExtract(page);
    await capture(page, testInfo, "extraction-result", {
      result: "extracted",
      surface_tab: "night",
      debug_telemetry: false,
      status_debug_copy: false,
      run_panel_visible: true,
      night_build_choice_visible: true,
      night_tomorrow_plan_visible: true,
      starter_resource_target_visible: true,
    });

    await page.keyboard.press("Enter");
    await page.waitForTimeout(500);
    await capture(page, testInfo, "upgrade-tab", {
      result: "extracted",
      surface_tab: "upgrades",
      debug_telemetry: false,
      status_debug_copy: false,
      upgrade_panel_visible: true,
    });

    await page.keyboard.press("Enter");
    await page.waitForTimeout(500);
    await capture(page, testInfo, "upgrade-tab-missing-build-plan", {
      result: "extracted",
      surface_tab: "upgrades",
      debug_telemetry: false,
      status_debug_copy: false,
      upgrade_panel_visible: true,
      upgrade_feedback_next_plan_visible: true,
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
      status_debug_copy: false,
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
      status_debug_copy: false,
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
      status_debug_copy: false,
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
      status_debug_copy: false,
      active_stats_visible: true,
      route_stage: "lower_connector",
    });
  });

  test("captures the staged Blue Chimney lower pocket view", async ({ page }, testInfo) => {
    await bootGame(page);
    await stageBlueChimneyPocket(page);
    await capture(page, testInfo, "blue-chimney-pocket-staged", {
      result: "diving",
      debug_telemetry: false,
      status_debug_copy: false,
      active_stats_visible: true,
      route_stage: "blue_chimney_pocket",
    });
  });

  test("captures the staged Blue Chimney draft payoff view", async ({ page }, testInfo) => {
    await bootGame(page);
    await stageBlueChimneyPayoff(page);
    await capture(page, testInfo, "blue-chimney-payoff-staged", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "blue_chimney_payoff",
      blue_chimney_draft_reading_recovered: true,
    });
  });

  test("captures the staged Silt Vein Fork view", async ({ page }, testInfo) => {
    await bootGame(page);
    await stageSiltVeinFork(page);
    await capture(page, testInfo, "silt-vein-fork-staged", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "silt_vein_fork",
      lantern_silt_sample_recovered: false,
    });
  });

  test("captures the staged Blackwater route sequence view", async ({ page }, testInfo) => {
    await bootGame(page);
    await stageBlackwaterRoute(page);
    await capture(page, testInfo, "blackwater-route-staged", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "blackwater_route",
      blackwater_trace_recovered: false,
    });
  });

  test("captures the staged Dusk Trench route and Glass Kelp payoff views", async ({ page }, testInfo) => {
    await bootGame(page);
    await stageDuskTrenchRoute(page);
    await capture(page, testInfo, "dusk-trench-route-staged", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "dusk_trench_route",
      dusk_trench_reached: true,
      glass_kelp_reading_recovered: false,
    });

    await stageDuskTrenchPayoff(page);
    await capture(page, testInfo, "dusk-trench-payoff-staged", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "dusk_trench_payoff",
      dusk_trench_reached: true,
      glass_kelp_reading_recovered: false,
    });

    await stageDuskTrenchPayoffRecovered(page);
    await capture(page, testInfo, "dusk-trench-payoff-recovered-staged", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "dusk_trench_payoff_recovered",
      dusk_trench_reached: true,
      glass_kelp_reading_recovered: true,
    });
  });

  test("captures the staged Hollow Reef side-cave branch views", async ({ page }, testInfo) => {
    await bootGame(page);
    await stageHollowReefRoute(page);
    await capture(page, testInfo, "hollow-reef-entrance-staged", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "hollow_reef_route",
      dusk_trench_reached: true,
      hollow_reef_reading_recovered: false,
    });

    await stageHollowReefPayoff(page);
    await capture(page, testInfo, "hollow-reef-payoff-staged", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "hollow_reef_payoff",
      dusk_trench_reached: true,
      hollow_reef_reading_recovered: false,
    });

    await stageHollowReefReturn(page);
    await capture(page, testInfo, "hollow-reef-return-staged", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "hollow_reef_return",
      dusk_trench_reached: true,
      hollow_reef_reading_recovered: true,
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

  test("captures the staged Outer Shelf survey and Glass Rim route view", async ({ page }, testInfo) => {
    await bootGame(page);
    await stageOuterShelfSurvey(page);
    await capture(page, testInfo, "outer-shelf-survey-staged", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      route_stage: "outer_shelf_survey",
      outer_shelf_survey_recovered: false,
      tideglass_sample_recovered: false,
      salvage_manifest_recovered: false,
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

  test("captures health damage distinct from oxygen loss", async ({ page }, testInfo) => {
    await bootGame(page);
    await stageHealthDamage(page);
    await capture(page, testInfo, "thermal-vent-health-damage", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      touch_controls_visible: false,
      player_rendered: true,
      player_on_screen: true,
      route_stage: "thermal_vent_health_damage",
      health: 82,
      max_health: 100,
      oxygen: 30,
      health_damage_events: 1,
      last_health_damage_amount: 18,
      health_damage_status_visible: true,
      health_damage_prompt_visible: true,
      health_damage_objective_visible: true,
    });
  });

  test("captures daylight timer progression HUD states", async ({ page }, testInfo) => {
    await bootGame(page);

    await stageDaylightState(page, "daylight_morning", 85);
    await capture(page, testInfo, "daylight-timer-morning", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      touch_controls_visible: false,
      player_rendered: true,
      player_on_screen: true,
      daylight_visible: true,
      daylight_remaining_percent: 85,
    });

    await stageDaylightState(page, "daylight_evening", 25);
    await capture(page, testInfo, "daylight-timer-evening", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      touch_controls_visible: false,
      player_rendered: true,
      player_on_screen: true,
      daylight_visible: true,
      daylight_remaining_percent: 25,
    });
  });

  test("captures surface oxygen refill without ship banking", async ({ page }, testInfo) => {
    await bootGame(page);
    await stageSurfaceOxygenRefill(page);
    await capture(page, testInfo, "surface-oxygen-refill-away-from-ship", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      touch_controls_visible: false,
      player_rendered: true,
      player_on_screen: true,
      route_stage: "surface_oxygen_refill",
      player_in_base: false,
      player_in_surface_oxygen_refill: true,
      surface_oxygen_refill_active: true,
      cargo_count: 1,
      cargo_text: "1 / 3",
      objective_text: "Surface: refill O2; ship banks",
      status_text: "Surface O2 refilling; ship still banks cargo.",
    });
  });

  test("captures ship offload while daylight continues", async ({ page }, testInfo) => {
    await bootGame(page);
    await stageShipOffload(page);
    await capture(page, testInfo, "ship-offload-repeat-sortie", {
      result: "diving",
      debug_telemetry: false,
      active_stats_visible: true,
      touch_controls_visible: false,
      player_rendered: true,
      player_on_screen: true,
      route_stage: "ship_offload_complete",
      player_in_base: true,
      cargo_count: 0,
      ship_offload_count: 1,
      cargo_text: "0 / 3",
      objective_text: "At ship: dive again",
      status_text: "Ship banked cargo; O2 full. Dive again.",
    });
  });
});
