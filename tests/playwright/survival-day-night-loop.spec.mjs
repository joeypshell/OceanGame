import { test } from "@playwright/test";
import { bootGame, capture, stageDaylightState, stageShipOffload, stageSurfaceOxygenRefill } from "./visual-helpers.mjs";

test.describe("OceanGame Survival Day/Night loop visual proof", () => {
  test("captures deterministic dawn, daylight, surface, offload, night, and tomorrow states", async ({ page }, testInfo) => {
    const scenario = {
      scenario: "survival_day_night_loop",
      milestone: "Survival Day/Night Loop",
      note: "Representative existing states for screenshot review; not golden-image approval.",
    };

    await bootGame(page);
    await capture(page, testInfo, "survival-loop-01-dawn-ready-plan", {
      result: "ready",
      surface_tab: "result",
      debug_telemetry: false,
      status_debug_copy: false,
      run_panel_visible: true,
      dawn_priority_visible: true,
    }, {
      ...scenario,
      step: "dawn ready plan",
      reviewerFocus: "Base needs, day priority, and next-dive setup are visible before launch.",
    });

    await stageDaylightState(page, "daylight_morning", 85);
    await capture(page, testInfo, "survival-loop-02-active-day-hud", {
      result: "diving",
      debug_telemetry: false,
      status_debug_copy: false,
      active_stats_visible: true,
      touch_controls_visible: false,
      player_rendered: true,
      player_on_screen: true,
      daylight_visible: true,
      daylight_remaining_percent: 85,
      oxygen_state: "normal",
      health: 100,
      max_health: 100,
    }, {
      ...scenario,
      step: "active daylight sortie",
      reviewerFocus: "Daylight, oxygen, health, cargo, player, and controls read clearly together.",
    });

    await stageSurfaceOxygenRefill(page);
    await capture(page, testInfo, "survival-loop-03-surface-oxygen-refill", {
      result: "diving",
      debug_telemetry: false,
      status_debug_copy: false,
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
    }, {
      ...scenario,
      step: "surface oxygen refill away from ship",
      reviewerFocus: "Surface refill is clearly oxygen-only and does not imply cargo banking.",
    });

    await stageShipOffload(page);
    await capture(page, testInfo, "survival-loop-04-ship-offload-repeat-sortie", {
      result: "diving",
      debug_telemetry: false,
      status_debug_copy: false,
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
    }, {
      ...scenario,
      step: "ship offload while daylight continues",
      reviewerFocus: "Ship offload is a fast bank action and the day is still active.",
    });

    await stageDaylightState(page, "daylight_nightfall", 0);
    await page.keyboard.press("Enter");
    await page.waitForTimeout(500);
    await capture(page, testInfo, "survival-loop-05-night-result-tomorrow-plan", {
      result: "extracted",
      surface_tab: "night",
      debug_telemetry: false,
      status_debug_copy: false,
      run_panel_visible: true,
      night_build_choice_visible: true,
      night_tomorrow_plan_visible: true,
      starter_resource_target_visible: true,
      ship_offload_count: 1,
    }, {
      ...scenario,
      step: "night result and tomorrow plan",
      reviewerFocus: "Night result, build choice, survival costs, and tomorrow prompt are visible.",
    });

    await page.keyboard.press("KeyR");
    await page.waitForTimeout(700);
    await capture(page, testInfo, "survival-loop-06-next-dawn-ready", {
      result: "ready",
      surface_tab: "result",
      debug_telemetry: false,
      status_debug_copy: false,
      run_panel_visible: true,
      dawn_priority_visible: true,
    }, {
      ...scenario,
      step: "next dawn setup",
      reviewerFocus: "Next day returns to a ready plan instead of leaving the player in unresolved night state.",
    });
  });
});
