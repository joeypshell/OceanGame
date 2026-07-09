import { expect, test } from "@playwright/test";
import crypto from "node:crypto";
import fs from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  bootGame,
  capture,
  stageArea01CentralDrop,
  stageArea01DeepSpine,
  stageArea01FutureExit,
  stageArea01LeftShelfCave,
  stageArea01RightChamber,
  stageArea01RightShelfPocket,
  stageArea01SurfaceEntry,
  stageArea01WestChamber,
} from "./visual-helpers.mjs";

const manifestUrl = new URL("./area01-capture-manifest.json", import.meta.url);
const sourceMapUrl = new URL("../../data/maps/area_01_runtime_geometry.generated.json", import.meta.url);
const repoRoot = fileURLToPath(new URL("../../", import.meta.url));

const stageHelpers = {
  area01_surface_entry: stageArea01SurfaceEntry,
  area01_left_shelf_cave: stageArea01LeftShelfCave,
  area01_right_shelf_pocket: stageArea01RightShelfPocket,
  area01_central_drop: stageArea01CentralDrop,
  area01_west_chamber: stageArea01WestChamber,
  area01_right_chamber: stageArea01RightChamber,
  area01_deep_spine: stageArea01DeepSpine,
  area01_future_exit: stageArea01FutureExit,
};

test.describe("OceanGame Area 01 shell captures", () => {
  test("captures representative first-room shell states", async ({ page }, testInfo) => {
    const manifest = await readManifest();
    const sourceMap = await readJson(sourceMapUrl);
    const evidence = [];
    expect(sourceMap.status ?? "unknown", "Area 01 shell captures should report generated source-map authority").toBe(
      "generated_current",
    );
    await bootGame(page);

    for (const captureState of manifest.captures) {
      const stage = stageHelpers[captureState.stage_command];
      if (!stage) {
        throw new Error(`Unknown Area 01 capture stage command: ${captureState.stage_command}`);
      }

      await stage(page);
      if (captureState.toggle_source_map_overlay) {
        await page.keyboard.press("F10");
      }

      const result = await capture(page, testInfo, captureState.id, captureState.expected_state, {
        manifest_id: manifest.manifest_id,
        source_map_revision: manifest.source_map_revision,
        source_map_status: sourceMap.status ?? "unknown",
        expected_visible_cue_families: captureState.expected_visible_cue_families,
        expected_route_area_label_policy: captureState.expected_route_area_label_policy,
        reason: captureState.reason,
      });
      assertPlayerVisibleInCapture(result);
      assertGameplayObjectsVisibleInCapture(captureState, result);
      const visualTruthGate = buildVisualTruthGate(captureState, result);
      assertVisualTruthGateShape(visualTruthGate, result.capture);
      evidence.push({
        id: captureState.id,
        stage_command: captureState.stage_command,
        source_map_revision: manifest.source_map_revision,
        expected_visible_cue_families: captureState.expected_visible_cue_families,
        expected_route_area_label_policy: captureState.expected_route_area_label_policy,
        reason: captureState.reason,
        captured_at: result.capturedAt,
        viewport: result.viewport,
        visual_state: result.visualState,
        cue_family_diagnostic_summary: {
          counts: result.visualState.area01_cue_family_counts ?? {},
          warnings: result.visualState.area01_cue_family_warnings ?? [],
        },
        visual_truth_gate: visualTruthGate,
        gameplay_object_visibility: buildGameplayObjectVisibilitySummary(captureState, result),
        artifacts: {
          screenshot: `${captureState.id}.png`,
          metadata: `${captureState.id}.json`,
        },
        validation: {
          state_assertions: "passed",
        },
      });
    }

    await writeEvidenceReport(testInfo, manifest, sourceMap, evidence);
  });
});

function assertPlayerVisibleInCapture(result) {
  const playerState = result.visualState.player_visual_state ?? {};
  expect(playerState.available, `${result.capture}: player visual state`).toBe(true);
  expect(playerState.player_visible, `${result.capture}: player node visible`).toBe(true);
  expect(playerState.visual_root_visible, `${result.capture}: player visual root visible`).toBe(true);
  expect(playerState.sprite_visible, `${result.capture}: player sprite visible`).toBe(true);
  expect(playerState.sprite_has_texture, `${result.capture}: player sprite texture loaded`).toBe(true);
  expect(playerState.visual_effective_z, `${result.capture}: player actor z band`).toBeGreaterThanOrEqual(20);

  if (result.capture === "area01-surface-entry") {
    expect(playerState.screen_x, "surface-entry diver should not sit under the left HUD").toBeGreaterThan(360);
    expect(playerState.screen_y, "surface-entry diver should be below the top HUD").toBeGreaterThan(280);
    expect(playerState.screen_y, "surface-entry diver should not sit under the toolbelt").toBeLessThan(
      result.viewport.height - 120,
    );
  }
}

function assertGameplayObjectsVisibleInCapture(captureState, result) {
  const visualState = result.visualState ?? {};
  const expectedResourceCount = Number(captureState.expected_min_resource_on_screen_count ?? 0);
  if (expectedResourceCount > 0) {
    expect(
      Number(visualState.area01_visible_resource_on_screen_count ?? 0),
      `${result.capture}: resource silhouettes on screen`,
    ).toBeGreaterThanOrEqual(expectedResourceCount);
  }

  if (captureState.expected_lantern_fry_on_screen === true) {
    const fryState = visualState.area01_lantern_fry_visual_state ?? {};
    expect(visualState.area01_lantern_fry_rendered, `${result.capture}: Lantern Fry rendered`).toBe(true);
    expect(visualState.area01_lantern_fry_on_screen, `${result.capture}: Lantern Fry on screen`).toBe(true);
    expect(fryState.sprite_has_texture, `${result.capture}: Lantern Fry sprite texture`).toBe(true);
    expect(Number(fryState.visual_effective_z ?? 0), `${result.capture}: Lantern Fry object z band`).toBeGreaterThanOrEqual(17);
    expect(Number(fryState.visual_effective_z ?? 99), `${result.capture}: Lantern Fry below player z band`).toBeLessThan(
      Number((visualState.player_visual_state ?? {}).visual_effective_z ?? 20),
    );
  }
}

function buildGameplayObjectVisibilitySummary(captureState, result) {
  const visualState = result.visualState ?? {};
  return {
    expected_min_resource_on_screen_count: Number(captureState.expected_min_resource_on_screen_count ?? 0),
    resource_on_screen_count: Number(visualState.area01_visible_resource_on_screen_count ?? 0),
    expected_lantern_fry_on_screen: captureState.expected_lantern_fry_on_screen === true,
    lantern_fry_rendered: Boolean(visualState.area01_lantern_fry_rendered),
    lantern_fry_on_screen: Boolean(visualState.area01_lantern_fry_on_screen),
    lantern_fry_visual_state: visualState.area01_lantern_fry_visual_state ?? {},
  };
}

function buildVisualTruthGate(captureState, result) {
  const counts = result.visualState.area01_cue_family_counts ?? {};
  const warnings = result.visualState.area01_cue_family_warnings ?? [];
  const expectedFamilies = captureState.expected_visible_cue_families ?? [];
  const missingFamilies = expectedFamilies.filter((family) => Number(counts[family] ?? 0) <= 0);
  const playerFacing = captureState.toggle_source_map_overlay !== true;
  const blockerSignals = [];

  for (const warning of warnings) {
    blockerSignals.push(`cue warning: ${warning}`);
  }

  for (const family of missingFamilies) {
    blockerSignals.push(`missing expected cue family: ${family}`);
  }

  if (playerFacing && !result.screenshot) {
    blockerSignals.push("missing player-facing screenshot artifact");
  }

  const expectedResourceCount = Number(captureState.expected_min_resource_on_screen_count ?? 0);
  const resourceOnScreenCount = Number(result.visualState.area01_visible_resource_on_screen_count ?? 0);
  if (expectedResourceCount > 0 && resourceOnScreenCount < expectedResourceCount) {
    blockerSignals.push(`resource silhouettes on screen: expected ${expectedResourceCount}, got ${resourceOnScreenCount}`);
  }

  if (captureState.expected_lantern_fry_on_screen === true && result.visualState.area01_lantern_fry_on_screen !== true) {
    blockerSignals.push("Lantern Fry sprite is not rendered on screen");
  }

  return {
    player_facing_capture: playerFacing,
    automated_gate_passed: blockerSignals.length === 0,
    closeout_allowed_without_manual_review: false,
    blocker_signals: blockerSignals,
    required_review_questions: [
      "Do cave walls read as natural solid terrain instead of debug collision outlines?",
      "Is terrain body/fill/texture visible beyond the left and bottom chunks?",
      "Is solid terrain clearly separated from playable water?",
      "Is the scan target or prompted resource visually identifiable near the reticle?",
      "Are fish and resource silhouettes visible above terrain/rim decoration when expected?",
      "Are horizontal banding and flat placeholder-like polygon artifacts absent?",
    ],
  };
}

function assertVisualTruthGateShape(visualTruthGate, captureName) {
  expect(
    Array.isArray(visualTruthGate.required_review_questions),
    `${captureName}: visual truth review questions`,
  ).toBe(true);
  expect(
    visualTruthGate.required_review_questions.length,
    `${captureName}: visual truth review question count`,
  ).toBeGreaterThanOrEqual(5);
  expect(
    Array.isArray(visualTruthGate.blocker_signals),
    `${captureName}: visual truth blocker signals`,
  ).toBe(true);
  expect(
    visualTruthGate.closeout_allowed_without_manual_review,
    `${captureName}: Area 01 visual closeout requires screenshot review`,
  ).toBe(false);
}

async function readManifest() {
  return readJson(manifestUrl);
}

async function readJson(url) {
  return JSON.parse(await fs.readFile(url, "utf8"));
}

async function writeEvidenceReport(testInfo, manifest, sourceMap, captures) {
  const generatedAt = new Date().toISOString();
  const visualTruthSummary = buildVisualTruthSummary(captures);
  const report = {
    report_id: "area01_shell_capture_evidence",
    generated_at: generatedAt,
    manifest_id: manifest.manifest_id,
    source_map_revision: manifest.source_map_revision,
    source_map_status: sourceMap.status ?? "unknown",
    capture_count: captures.length,
    visual_truth_gate_summary: visualTruthSummary,
    change_signatures: await buildChangeSignatures(),
    validation_command_results: [
      {
        command: "npm run test:area01-shell-captures",
        result: "passed",
        note:
          "This report is written after capture state assertions and screenshots complete; visual closeout still depends on the visual_truth_gate_summary.",
      },
      {
        command: "git diff --check",
        result: "run separately before commit",
        note: "Whitespace validation is intentionally outside the browser capture command.",
      },
    ],
    manual_review_checklist: [
      "Confirm the water surface is fully open in area01-surface-entry.",
      "Confirm terrain walls, rim/lip reads, and collision reads agree with the overlay capture.",
      "Confirm cave walls read as natural terrain, not debug collision outlines or flat placeholder polygons.",
      "Confirm terrain fill/texture coverage is visible across central and right-side cave walls, not only left/bottom chunks.",
      "Confirm solid terrain and playable water remain visually distinct in each player-facing capture.",
      "Confirm scan targets and prompted resources are visually identifiable near the reticle or prompt.",
      "Confirm horizontal banding and large untextured flat shapes are absent from primary cave views.",
      "Confirm resources, scannables, and promise cues are in water pockets, not embedded inside solid walls.",
      "Do not close Area 01 visual/map issues when visual_truth_gate_summary.automated_gate_passed is false or blocker_signals are present.",
      "Compare change_signatures to prior reports: source_map means source truth changed; scene_runtime means Godot scene/scripts changed; docs means documentation-only context changed.",
      "Do not treat these captures as golden images; use them as deterministic review evidence.",
    ],
    captures,
  };

  const jsonPath = testInfo.outputPath("area01-shell-capture-evidence.json");
  const markdownPath = testInfo.outputPath("area01-shell-capture-evidence.md");
  await fs.writeFile(jsonPath, `${JSON.stringify(report, null, 2)}\n`);
  await fs.writeFile(markdownPath, renderMarkdownReport(report));
  testInfo.attachments.push({ name: "area01-shell-capture-evidence-json", path: jsonPath, contentType: "application/json" });
  testInfo.attachments.push({ name: "area01-shell-capture-evidence-md", path: markdownPath, contentType: "text/markdown" });
}

function buildVisualTruthSummary(captures) {
  const playerFacingCaptures = captures.filter((captureResult) => captureResult.visual_truth_gate.player_facing_capture);
  const capturesWithBlockers = captures.filter(
    (captureResult) => captureResult.visual_truth_gate.blocker_signals.length > 0,
  );
  return {
    automated_gate_passed: capturesWithBlockers.length === 0,
    player_facing_capture_count: playerFacingCaptures.length,
    captures_with_blockers: capturesWithBlockers.map((captureResult) => captureResult.id),
    blocker_signals: capturesWithBlockers.flatMap((captureResult) =>
      captureResult.visual_truth_gate.blocker_signals.map((signal) => `${captureResult.id}: ${signal}`),
    ),
    closeout_rule:
      "Generated screenshots must be opened or attached before closing Area 01 visual/map issues; passing Playwright state assertions alone is not sufficient.",
  };
}

async function buildChangeSignatures() {
  return {
    source_map: await hashGroup([sourceMapUrl]),
    scene_runtime: await hashGroup([
      new URL("../../scenes/Main.tscn", import.meta.url),
      new URL("../../scripts/main.gd", import.meta.url),
      new URL("../../scripts/area01_blockout_builder.gd", import.meta.url),
      new URL("../../scripts/area01_source_map_overlay.gd", import.meta.url),
      new URL("../../scripts/area01_visual_cue_contract.gd", import.meta.url),
    ]),
    capture_harness: await hashGroup([
      manifestUrl,
      new URL("./area01-shell-captures.spec.mjs", import.meta.url),
      new URL("./visual-helpers.mjs", import.meta.url),
      new URL("./area01-shell-captures.config.mjs", import.meta.url),
    ]),
    docs: await hashGroup([
      new URL("../../docs/current/TOOLING.md", import.meta.url),
      new URL("../../docs/current/SCREENSHOT_WORKFLOW.md", import.meta.url),
    ]),
  };
}

async function hashGroup(urls) {
  const files = [];
  const groupHash = crypto.createHash("sha256");
  for (const url of urls) {
    const content = await fs.readFile(url);
    const digest = crypto.createHash("sha256").update(content).digest("hex");
    groupHash.update(digest);
    files.push({
      path: pathFromRepoUrl(url),
      sha256: digest,
    });
  }
  return {
    sha256: groupHash.digest("hex"),
    files,
  };
}

function pathFromRepoUrl(url) {
  return path.relative(repoRoot, fileURLToPath(url)).replaceAll(path.sep, "/");
}

function renderMarkdownReport(report) {
  const lines = [
    "# Area 01 Shell Capture Evidence",
    "",
    `Generated: ${report.generated_at}`,
    `Manifest: ${report.manifest_id}`,
    `Source map: ${report.source_map_revision}`,
    `Source map status: ${report.source_map_status}`,
    "",
    "## Visual Truth Gate",
    "",
    `Automated gate passed: ${report.visual_truth_gate_summary.automated_gate_passed}`,
    `Player-facing captures: ${report.visual_truth_gate_summary.player_facing_capture_count}`,
    `Captures with blockers: ${report.visual_truth_gate_summary.captures_with_blockers.join(", ") || "none"}`,
    `Closeout rule: ${report.visual_truth_gate_summary.closeout_rule}`,
    "",
  ];

  if (report.visual_truth_gate_summary.blocker_signals.length > 0) {
    lines.push("### Blocker Signals", "");
    for (const blocker of report.visual_truth_gate_summary.blocker_signals) {
      lines.push(`- ${blocker}`);
    }
    lines.push("");
  }

  lines.push(
    "## Change Signatures",
    "",
  );

  for (const [group, signature] of Object.entries(report.change_signatures)) {
    lines.push(`- ${group}: ${signature.sha256}`);
  }

  lines.push("", "## Captures", "");
  for (const captureResult of report.captures) {
    const familyCounts = JSON.stringify(captureResult.cue_family_diagnostic_summary.counts);
    const warnings = captureResult.cue_family_diagnostic_summary.warnings.join("; ") || "none";
    const objectVisibility = captureResult.gameplay_object_visibility ?? {};
    lines.push(
      `- ${captureResult.id}: ${captureResult.stage_command}`,
      `  - reason: ${captureResult.reason}`,
      `  - source map: ${captureResult.source_map_revision}`,
      `  - cue families: ${familyCounts}`,
      `  - warnings: ${warnings}`,
      `  - gameplay objects: resources on screen ${objectVisibility.resource_on_screen_count ?? 0}/${objectVisibility.expected_min_resource_on_screen_count ?? 0}, Lantern Fry on screen ${objectVisibility.lantern_fry_on_screen ?? false}`,
      `  - visual truth gate: ${captureResult.visual_truth_gate.automated_gate_passed ? "passed" : "blockers present"}`,
      `  - artifacts: ${captureResult.artifacts.screenshot}, ${captureResult.artifacts.metadata}`,
    );
    for (const question of captureResult.visual_truth_gate.required_review_questions) {
      lines.push(`  - review: ${question}`);
    }
  }

  lines.push("", "## Validation", "");
  for (const result of report.validation_command_results) {
    lines.push(`- ${result.command}: ${result.result}`);
  }

  lines.push("", "## Manual Review Checklist", "");
  for (const item of report.manual_review_checklist) {
    lines.push(`- ${item}`);
  }
  lines.push("");
  return `${lines.join("\n")}\n`;
}
