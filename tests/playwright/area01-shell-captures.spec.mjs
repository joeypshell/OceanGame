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
const sourceMapUrl = new URL("../../docs/planning/maps/area_01_runtime_source_map_v3.json", import.meta.url);
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

async function readManifest() {
  return readJson(manifestUrl);
}

async function readJson(url) {
  return JSON.parse(await fs.readFile(url, "utf8"));
}

async function writeEvidenceReport(testInfo, manifest, sourceMap, captures) {
  const generatedAt = new Date().toISOString();
  const report = {
    report_id: "area01_shell_capture_evidence",
    generated_at: generatedAt,
    manifest_id: manifest.manifest_id,
    source_map_revision: manifest.source_map_revision,
    source_map_status: sourceMap.status ?? "unknown",
    capture_count: captures.length,
    change_signatures: await buildChangeSignatures(),
    validation_command_results: [
      {
        command: "npm run test:area01-shell-captures",
        result: "passed",
        note: "This report is written after all manifest capture state assertions and screenshots complete.",
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
      "Confirm resources, scannables, and promise cues are in water pockets, not embedded inside solid walls.",
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

async function buildChangeSignatures() {
  return {
    source_map: await hashGroup([new URL("../../docs/planning/maps/area_01_runtime_source_map_v3.json", import.meta.url)]),
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
    "## Change Signatures",
    "",
  ];

  for (const [group, signature] of Object.entries(report.change_signatures)) {
    lines.push(`- ${group}: ${signature.sha256}`);
  }

  lines.push("", "## Captures", "");
  for (const captureResult of report.captures) {
    const familyCounts = JSON.stringify(captureResult.cue_family_diagnostic_summary.counts);
    const warnings = captureResult.cue_family_diagnostic_summary.warnings.join("; ") || "none";
    lines.push(
      `- ${captureResult.id}: ${captureResult.stage_command}`,
      `  - reason: ${captureResult.reason}`,
      `  - source map: ${captureResult.source_map_revision}`,
      `  - cue families: ${familyCounts}`,
      `  - warnings: ${warnings}`,
      `  - artifacts: ${captureResult.artifacts.screenshot}, ${captureResult.artifacts.metadata}`,
    );
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
